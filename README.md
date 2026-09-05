# sheepit-docker-client
Docker Container for [Sheepit-Renderfarm](https://www.sheepit-renderfarm.com) Client

## Quick Start
The fastest way to start contributing your computing power is by running the container directly with the command below. It will automatically download the image and run the container in the background.

```bash
docker run -d \
    --name sheepit \
    ghcr.io/rudolfortner/sheepit-docker-client:latest
```

## Configuration
By default the renderer contributes to the account of [ortner-effects](https://ortner-effects.com). The container can also be configured via environment variables in the following way:
```bash
docker run -d \
    --name sheepit \
    -e SHEEPIT_LOGIN=<login> \
    -e SHEEPIT_PASSWORD=<password> \
    ghcr.io/rudolfortner/sheepit-docker-client:latest
```

This list shows all available environment variables:

* SHEEPIT_CACHE_DIR
* SHEEPIT_COMPUTE_METHOD
* SHEEPIT_CONFIG
* SHEEPIT_CORES
* SHEEPIT_EXTRAS
* SHEEPUT_GPU
* SHEEPIT_HOSTNAME
* SHEEPIT_LOGIN
* SHEEPIT_MEMORY
* SHEEPIT_PASSWORD
* SHEEPIT_PRIORITY
* SHEEPIT_PROXY
* SHEEPIT_RENDERTIME
* SHEEPIT_REQUEST_TIME
* SHEEPIT_SERVER
* SHEEPIT_SHARED_ZIP
* SHEEPIT_SHUTDOWN
* SHEEPIT_SHUTDOWN_MODE
* SHEEPIT_THEME
* SHEEPIT_TITLE
* SHEEPIT_UI


