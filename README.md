## moodle-dev
Container Docker images for building moodle and Docker compose file for launching moodle with mysql database.

## Installation
git clone https://github.com/moodle/moodle.git

git checkout MOODLE_405_STABLE

Copy the docker file and compose file in root directory (Make sure docker and compose are installed)

Run docker compose up -d

go to localhost:8080 to access the app

In the UI, when asked for database info, use DB_HOST = mysql (service name in compose file), USER = root, PASSWORD = root, DATABASE = moodle
