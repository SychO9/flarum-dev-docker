## Usage

* Create a new project with `git clone git@github.com:SychO9/flarum-dev-container.git flarum-dev-name`.
* Customize the environment variables in the `.env` file.
* Clone any extension you wish to develop into the `workbench` directory.
* Clone the `flarum/framework` repository into the root directory if you wish to develop Flarum itself.
* Build the containers with `docker-compose build`.
* Run the containers with `docker-compose up -d`.
* Add a virtual host to your local machine that points to the configured `APP_URL` in the `.env` file.
* Access the site in your browser through the `APP_URL` (http://flarum-dev.lan:8082).
* Hack away!

> **Warning**
> Deleting the generated `config.php` file after the first run will reset the database and all data will be lost. If you mistakely delete the file, just copy it back from the `.config.php` file.

## Environment

### General
* PHP 8.2
* MySQL 8.0
* Nginx

### Flarum Specific
* Flarum CLI
* Fake Data and clockwork extensions

## Todo
* Install Xdebug
