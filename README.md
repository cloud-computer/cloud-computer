# Cloud Computer

The cloud computer is a one click deploy computer accessible through any web browser. It can be run on-premises, or on a cloud provider. It can be thought of as an open source [Citrix Receiver](https://user-images.githubusercontent.com/1094600/64485122-9f6da580-d25f-11e9-83a0-e6a63a9fe9fa.png).

## Supported Applications

|||||||
|-|-|-|-|-|-|
| VS Code | Blender | Chrome | Krita | Darktable | Slack |
| <a href="https://code.visualstudio.com"><img src="apps/launcher/src/icon-images/icon-vs-code.png" width="50" height="50" /></a> | <a href="https://www.blender.org"><img src="apps/launcher/src/icon-images/icon-blender.png" width="50" height="50" /></a> | <a href="https://www.google.com/chrome/"><img src="apps/launcher/src/icon-images/icon-chrome.png" width="50" height="50" /></a> | <a href="https://krita.org"><img src="apps/launcher/src/icon-images/icon-krita.png" width="50" height="50" /></a> | <a href="https://www.darktable.org"><img src="apps/launcher/src/icon-images/icon-darktable.png" width="50" height="50" /></a> | <a href="https://slack.com/"><img src="apps/launcher/src/icon-images/icon-slack.png" width="50" height="50" /></a>
| Postman | KiCad | Notion | OnlyOffice | Terminal | Gnumeric |
| <a href="https://www.getpostman.com"><img src="apps/launcher/src/icon-images/icon-postman.png" width="50" height="50" /></a> | <a href="http://www.kicad-pcb.org"><img src="apps/launcher/src/icon-images/icon-kicad.png" width="50" height="50" /></a> | <a href="https://www.notion.so"><img src="apps/launcher/src/icon-images/icon-notion.png" width="50" height="50" /></a> | <a href="https://www.onlyoffice.com"><img src="apps/launcher/src/icon-images/icon-onlyoffice.png" width="50" height="50" /></a> | <a href="https://github.com/yudai/gotty"><img src="apps/launcher/src/icon-images/icon-terminal.png" width="50" height="50" /></a> | <a href="http://www.gnumeric.org"><img src="apps/launcher/src/icon-images/icon-gnumeric.png" width="50" height="50" /></a>
| Grafana ||||
| <a href="https://grafana.com"><img src="apps/launcher/src/icon-images/icon-grafana.png" width="50" height="50" /></a>

## Supported Storage

||||
|-|-|-|
| Drive | Dropbox | OneDrive | Krita | Darktable | Slack |
| <a href="https://www.google.com/drive"><img src="apps/launcher/src/icon-images/icon-google-drive.png" width="50" height="50" /></a> | <a href="https://www.dropbox.com"><img src="apps/launcher/src/icon-images/icon-dropbox.png" width="50" height="50" /></a> | <a href="https://onedrive.live.com"><img src="apps/launcher/src/icon-images/icon-onedrive.png" width="50" height="50" /></a>

## Getting Started

The cloud computer deploys with one command once cloud provider credentials are supplied.

1. Supply your cloud provider and domain name [configuration](#configuration).

2. Run `yarn create:cloud-computer`.

3. Open `https://terminal.your-domain.com` to access the terminal user interface or `https://desktop.your-domain.com` to access the desktop environment.

## Configuration

The cloud computer is hosted in the public cloud. This requires [credentials](infrastructure/credentials/cloud-provider.json) for creating cloud resources. Currently only Google Cloud Platform is supported.

The cloud computer is accessible via a URL. This requires a [domain name and credentials](infrastructure/dns/scripts/environment.sh) for configuring DNS. Currently only CloudFlare is supported.

## Technologies

The cloud computer is built on 100% open source technologies.

- [Docker](https://github.com/docker/docker-ce)
- [Git](https://github.com/git/git)
- [GoTTY](https://github.com/yudai/gotty)
- [Grafana](https://github.com/grafana/grafana)
- [Istio](https://github.com/istio/istio)
- [Jaeger](https://github.com/jaegertracing/jaeger)
- [Let's Encrypt](https://github.com/letsencrypt)
- [noVNC](https://github.com/novnc/noVNC)
- [Packer](https://github.com/hashicorp/packer)
- [Prometheus](https://github.com/prometheus/prometheus)
- [Terraform](https://github.com/hashicorp/terraform)
- [Tmux](https://github.com/tmux/tmux)
- [Traefik](https://github.com/containous/traefik)
- [TypeScript](https://github.com/Microsoft/TypeScript)
- [VS Code](https://github.com/codercom/code-server)
- [X11VNC](https://github.com/LibVNC/x11vnc)
- [Xvfb](https://www.x.org/releases/X11R7.6/doc/man/man1/Xvfb.1.xhtml)
- [Yarn](https://github.com/cloud-computer/yarn)
- [Zsh](https://github.com/zsh-users/zsh)

## Screenshots

![Launcher](https://user-images.githubusercontent.com/1094600/64403150-dfdfee80-d0ba-11e9-84e1-0041c8544424.png)
![Blender](https://user-images.githubusercontent.com/1094600/62818442-a3d46f00-bb8a-11e9-9828-59350f11cb7d.png)
![OnlyOffice Sheets](https://user-images.githubusercontent.com/1094600/62818492-51e01900-bb8b-11e9-83ce-dc2f2a5db5db.png)
![Desktop](https://user-images.githubusercontent.com/1094600/56347945-c2dc7900-6208-11e9-8ed2-0bbff2fee6a8.png)
![Terminal](https://user-images.githubusercontent.com/1094600/56299607-b2c88900-6177-11e9-912b-40ea25d690e3.png)
![Jaeger](https://raw.githubusercontent.com/kawing-ho/kawing-ho.github.io/master/assets/images/startup-yarn-2.png)
