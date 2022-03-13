# wolframengine-docker
Using the wolfram engine as docker.

Handles auth and stuff for non-interactive login + saves creds.

```
 sudo curl -L https://raw.githubusercontent.com/lizelive/wolframengine-docker/main/wolframscript.sh -o /usr/local/bin/wolframscript && sudo chmod +x /usr/local/bin/wolframscript
 ```

if it fails try
```
 sudo ln -s /usr/local/bin/wolframscript /usr/bin/wolframscript
```

before first run set env vars
`WOLFRAM_USERNAME`
`WOLFRAM_PASSWORD`

can also set
`WOLFRAM_VERSION` to be a tag from https://hub.docker.com/r/wolframresearch/wolframengine/tags to choose which version to use
`WOLFRAM_DOCKER_ARGS` to be docker args to use when running like `--gpus=all`