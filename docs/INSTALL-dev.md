## Installation on dev machine

- git clone https://github.com/Continuous-Security/discourse_reports.git plugins/discourse_reports
- clone the repo here
- `bin/rake discourse_reports:install:migrations`
- `bin/rake db:migrate SCOPE=discourse_reports`

[Or Use dockers instead](INSTALL-docker.md)
