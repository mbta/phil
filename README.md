# Phil

Phil is a backoffice-facing application used to manage card/pass fulfillment concerns.

[Product scope for Phil is documented in Notion here.](https://www.notion.so/mbta-downtown-crossing/Phil-Fulfillment-Product-Scope-30f5ec077fdf45fabdd33e5a367e4996?pvs=4)

## Requirements

* PostgreSQL (check the currently used version [here](https://github.com/mbta/devops/blob/9d4e4612c367b0e615b879eba59c1052bfa7bd96/terraform/modules/app-phil/main.tf#L135)), installed as you prefer:
  * [via Postgres.app](https://postgresapp.com/) (on macOS)
  * [via Homebrew](https://brew.sh/) (on macOS)
  * [directly installed](https://www.postgresql.org/download/)
  * [via Docker](https://hub.docker.com/_/postgres)
* If not available via your PostgreSQL install, `libpq` via Homebrew: `brew install libpq` (provides `psql`, `pg_dump`, and other PostgreSQL client CLI utilities)
* [asdf](https://asdf-vm.com/), with plugins for:
  * [Erlang](https://github.com/asdf-vm/asdf-erlang)
  * [Elixir](https://github.com/asdf-vm/asdf-elixir)
  * [Node.js](https://github.com/asdf-vm/asdf-nodejs)
  * [adr-tools](https://github.com/asdf-vm/asdf-plugins/blob/master/plugins/adr-tools)
* Update your `/etc/hosts` file (using `sudo` mode) to create a `phil.localhost` hostname by adding the following lines at the bottom:

  ```{sh}
  # MyCharlie for SSO setup with Keycloak in dev
  127.0.0.1	phil.localhost
  ```

  This is necessary because Keycloak is setup to route back to `phil.localhost` for dev use.
* Copy the `.envrc.template` file to `.envrc`, and update values in that new file with the correct information.
* Setup [direnv](https://direnv.net/) to automatically read the `.envrc` file.
  * [Install via Homebrew](https://formulae.brew.sh/formula/direnv#default): `brew install direnv`
  * You will want to [hook `direnv` into your shell](https://direnv.net/docs/hook.html). For example, for `zsh`, add the following lines to your `.zshrc`:
  
  ```{sh}
  # Setup direnv shell integration
  eval "$(direnv hook zsh)"
  ```
  * You may also need to run `direnv allow` from the repo root if you get a message saying the file is blocked. This happens the first time you use it, and when the `.envrc` file changes.

## Getting setup to run the app

* Run `asdf install` to get the correct language/tool versions via [the `.tool-versions` file](./.tool-versions)
* Run `mix setup` to install and setup dependencies and database

## Starting the app

* Start the Phoenix server:
  * Directly with `mix phx.server`
  * Inside IEx with `iex -S mix phx.server`
* Visit [`phil.localhost:4000`](http://phil.localhost:4000) from your browser

## Testing, linting and static analysis

Run tests with `mix test`

Run formatting and code analysis with the following:

* Run code formatting with `mix format`
* Run a full compile with `mix compile --force --all-warnings`
* Run linting with `mix credo --strict`
* Run static analysis with `mix dialyzer --quiet`
* Run security analysis with `mix sobelow --skip --verbose --ignore Config.HTTPS`

Note: all of these can be run in sequence with one command: `mix check`

## Deploying the app

Deployment is managed via Github Actions CI workflow **Deploy to Dev**.

* All merges to `main` branch are automatically deployed to the `staging` environment.
* Deploys to `staging`, `dev-red` and `dev-green` environments can also be accomplished by manually kicking off a CI run of [**Deploy to Dev** in the Github Actions tab](https://github.com/mbta/my_charlie/actions/workflows/deploy-dev.yml).

## Contributing to this Project

If you're thinking of contributing to this repo, please take a look at our [code of conduct](./CODE_OF_CONDUCT.md) and the [contributing guidelines](./CONTRIBUTING.md) to get started.
