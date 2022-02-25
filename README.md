# debian-i3-novnc-docker
Debian with i3 tiling window manager - Accessible in the browser using noVNC

Usage
-----

``` {.shell}
docker buildx build -t debian-i3-novnc
docker run --network=host --rm debian-i3-novnc
```

Then navigate to `http://yourhost.local:8080/vnc.html?&autoconnect=true&password=password&resize=remote` in your browser.

Hint: Modifier key (Alt or Win) + Enter to start terminals
