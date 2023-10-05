## Remote Extension Host Server Automatic Initalizer For Containers For VSCode OSS Builds
Implements REH server initalization, updating and startup for containers, targets Linux based systems.

Sort of "inspired by" [devcontainers](https://containers.dev/) in that it attempts to reach toward the same end goal.
Targeted toward OSS builds of VSCode.

## Installation
This is essentially made up of only shell scripts, for the time being. Only a few prerequisites are needed:

| package     | additional notes |
| :---------: | :--------------- |
| `bash`      | |
| `distrobox` | https://github.com/89luca89/distrobox |
| `make`      | Only for automatic installation (more below) |
| `vscode`    | any OSS and proprietary build *should* work (as well as their Flatpak counterparts) |

### Manual
1. Copy the contents of `bin/` to wherever you want, just make sure `PATH` is set to include the files.
2. Copy `share/remote.oss.update.vscodium-reh.sh` to either `/usr/local/share/` or `~/.local/share/`.

#### Flatpaks
Optionally, in order to intergrate better with the flatpak version of vscode builds you can copy
`com.vscodium.codium.desktop` and `com.vscodium.codium-url-handler.desktop` from `/var/lib/flatpak/exports/share/applications/`
to `~/.local/share/applications` and modify the `Exec` lines to be `Exec=codium <...>`.

## Future plans

- [ ] Develop an extension that is sort of a mix of [auto-run-command](https://github.com/GabiGrin/vscode-auto-run-command) and [remote-oss](https://github.com/xaberus/vscode-remote-oss) that accomplishes the same outcome of [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) while maintaining full compatibility with OSS builds.
