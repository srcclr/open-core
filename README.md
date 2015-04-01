# Discourse Reports Plugin

A simple plugins restructs topics comments.

[![Code Climate](https://codeclimate.com/github/Continuous-Security/discourse_reports/badges/gpa.svg)](https://codeclimate.com/github/Continuous-Security/discourse_reports)

## Required Discourse build: 1.3.0 beta 3

[The current live site build](https://github.com/discourse/discourse/tree/7ef306cd3bbffc1fe8e19d223c1024dd3caf2004)

## Installation

- [How to install on production](docs/INSTALL-docker.md)
- [How restore backup](docs/RESTORE-backup.md)
- [How to setup SSL](docs/CONFIGURE-ssl.md)
- [How to install on dev machine](docs/INSTALL-dev.md)

## Contributing

1. Fork it ( https://github.com/Continuous-Security/discourse_reports/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Testing

- Make sure you have installed `phantomjs`
- Run `bin/rspec` for rspec tests
- Run `bin/qunit` for qunit tests
