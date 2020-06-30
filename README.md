# docker-code-server-sbt
[![](https://img.shields.io/travis/frost-tb-voo/docker-code-server-sbt/master.svg?style=flat-square)](https://travis-ci.org/frost-tb-voo/docker-code-server-sbt/)
[![GitHub stars](https://img.shields.io/github/stars/frost-tb-voo/docker-code-server-sbt.svg?style=flat-square)](https://github.com/frost-tb-voo/docker-code-server-sbt/stargazers)
[![GitHub license](https://img.shields.io/github/license/frost-tb-voo/docker-code-server-sbt.svg?style=flat-square)](https://github.com/frost-tb-voo/docker-code-server-sbt/blob/master/LICENSE)
[![Docker pulls](https://img.shields.io/docker/pulls/novsyama/code-server-sbt.svg?style=flat-square)](https://hub.docker.com/r/novsyama/code-server-sbt)
[![Docker image-size](https://img.shields.io/docker/image-size/novsyama/code-server-sbt/latest?style=flat-square)](https://hub.docker.com/r/novsyama/code-server-sbt)
[![Docker layers](https://img.shields.io/microbadger/layers/novsyama/code-server-sbt.svg?style=flat-square)](https://microbadger.com/images/novsyama/code-server-sbt)

An unofficial extended VSCode [code-server](https://github.com/cdr/code-server) image for latest scala and sbt with [metals-vscode](https://github.com/scalameta/metals-vscode).
See [novsyama/code-server-sbt](https://hub.docker.com/r/novsyama/code-server-sbt/)

## How

```bash
PROJECT_DIR=<workspace absolute path>

sudo docker pull novsyama/code-server-sbt
sudo docker run --name=vscode --net=host -d \
 -v "${PROJECT_DIR}:/home/coder/project/code-server" \
 -w /home/coder/project \
 novsyama/code-server-sbt \
 code-server \
 --auth none
```

And open http://localhost:8080 with your favorites browser.
For detail options, see [code-server](https://github.com/cdr/code-server).

### Pathes of vscode code-server
If you want to preserve the settings and extensions, please mount following pathes with `-v` option of `docker run` command.

- Home : /home/coder
- Extension path : ~/.local/share/code-server/extensions
- Settings path : ~/.local/share/code-server/User/settings.json

### Install more extensions
- Download .vsix file from https://marketplace.visualstudio.com/.
- Put .vsix file into your project directory.
- Start the code-server container.
- Go to http://localhost:8080 and open the terminal and type
  - `code-server --install-extension $vsix_filepath`

## Similar official functionality in vscode
[Developing inside a Container](https://code.visualstudio.com/docs/remote/containers)

This requires local installed visual studio code.

## Contact
Please open an issue:

https://github.com/frost-tb-voo/docker-code-server-sbt/issues

And mension to @frost-tb-voo.
