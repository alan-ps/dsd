# Docker Simple Drupal

Minimal Docker environment for Drupal 11 — Nginx, PHP 8.5, MariaDB 11.4, xDebug.

### Prerequisites
[Docker](https://docs.docker.com/engine/installation) and [Docker Compose](https://docs.docker.com/compose/install)

> **Windows users:** run the install script from WSL or Git Bash.

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
