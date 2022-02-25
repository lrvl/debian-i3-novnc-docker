# syntax=docker/dockerfile:1.3-labs
FROM public.ecr.aws/debian/debian:bullseye-slim

ENV DEBIAN_FRONTEND noninteractive

RUN  apt-get update \
&& apt-get install --no-install-recommends \
ca-certificates \
dstat \
git \
i3 \
i3status \
iproute2 \
procps \
psmisc \
terminator \
tigervnc-standalone-server \
tigervnc-viewer \
tigervnc-xorg-extension \
websockify -y

COPY <<EOF /root/start.sh
#!/bin/bash
echo "Starting tigervnc server with i3"
/usr/bin/tigervncserver -xstartup i3
echo -n "Waiting for TCP port 5901 to become operational.. "
timeout -v 0 bash -c \"</dev/tcp/127.0.0.1/5901\" && echo \"Connection available\" || echo \"Connection failed\"
echo "Show listening TCP"
ss -tlp
echo "Starting novnc_proxy"
(cd && ./noVNC/utils/novnc_proxy --vnc 0.0.0.0:5901 --listen 8080)
echo "Starting last resort bash"
bash
EOF

RUN <<EOF
cd
git clone https://github.com/novnc/noVNC.git
printf "password\npassword\n\n" | vncpasswd
chmod +x /root/start.sh
EOF

ENTRYPOINT ["/root/start.sh"]
