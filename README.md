# Docker Simple Drupal

Minimal Docker environment for Drupal 11 — Nginx, PHP 8.5, MariaDB 11.4, xDebug.

### Prerequisites
[Docker](https://docs.docker.com/engine/installation) and [Docker Compose](https://docs.docker.com/compose/install)

> **Windows users:** run the install script from WSL or Git Bash.
>
> Clone and run the project from inside the WSL filesystem (e.g. `~/projects/`), **not** from the Windows filesystem (`/mnt/c/...`). When project files live on the Windows filesystem, Docker accesses them via a slow protocol bridge between Windows and WSL2, which causes significant I/O latency. This can lead to race conditions during Drupal installation — files written by Composer may not be visible to PHP-FPM in time, resulting in errors. Keeping files on the WSL filesystem eliminates the bridge and gives Docker native file access.

### Installation
1. Clone the repo `git clone https://github.com/alan-ps/dsd`
2. Start containers `docker compose up -d`
3. Run install `./.build/install.sh scratch`

The site will be available at `http://localhost:7080`.
Admin credentials: `admin` / `admin`.

### Install modes
| Command | Description |
|---|---|
| `./.build/install.sh scratch` | Fresh Drupal install |
| `./.build/install.sh db` | Import from existing database dump (`web/file.sql`) |

### Refs
- [drupal/recommended-project](https://github.com/drupal/recommended-project/tree/11.x)
