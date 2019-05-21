# Cloud Computer

Repeatable. Reliable. Infinitely Scalable.

The cloud computer is a one click deploy computer accessible through any web browser. It is composed of cloud native technologies with 100% infrastructure as code.

## Use Cases

### Unified Production and Development Environment

Environment differences between 'production' and 'development' are notorious for causing unexpected system failures. The cloud computer is infinitely scalable; deploy a 4 CPU 8GB RAM cloud computer for development, and scale it up to 120 CPU 256GB RAM for production. Same environment for development and production - no developer unfamiliarity.

## Getting Started

The cloud computer requires zero human interaction to deploy once cloud access configuration is supplied.

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
- [Packer](https://github.com/hashicorp/packer)
- [Prometheus](https://github.com/prometheus/prometheus)
- [Terraform](https://github.com/hashicorp/terraform)
- [Tmux](https://github.com/tmux/tmux)
- [Traefik](https://github.com/containous/traefik)
- [TypeScript](https://github.com/Microsoft/TypeScript)
- [VS Code](https://github.com/codercom/code-server)
- [X11VNC](https://github.com/LibVNC/x11vnc)
- [Xephyr](https://www.freedesktop.org/wiki/Software/Xephyr)
- [Yarn](https://github.com/cloud-computer/yarn)
- [Zsh](https://github.com/zsh-users/zsh)

### Why Yarn?

Yarn is the package manager for the web. It is also a task runner. It could be seen as overkill to use Yarn instead of shell scripts to automate the cloud computer operations. Yarn was chosen for its ability to leverage open source utilities in the JavaScript ecosystem, and for the modular structure it imposes using `package.json` files. These features solve two of the greatest pain points experienced in modern web development; frictionless reuse of open source code, and a maintainable project structure that can be navigated and automated programmatically.

Using Yarn creates a single point of entry for all automated operations. This single point of entry greatly simplifies tracing of cloud computer operations. To provide visibility on these operations, Jaeger visualizes OpenTracing data captured using the shim in `@cloud-computer/yarn-shim`. A Screenshot of trace output is below.

## Screenshots

![Desktop](https://user-images.githubusercontent.com/1094600/56347945-c2dc7900-6208-11e9-8ed2-0bbff2fee6a8.png)
![Terminal](https://user-images.githubusercontent.com/1094600/56299607-b2c88900-6177-11e9-912b-40ea25d690e3.png)
![Jaeger](https://raw.githubusercontent.com/kawing-ho/kawing-ho.github.io/master/assets/images/startup-yarn-2.png)
