# open-core

# Installation note

In order to set up a vagrant development environemnt please following the instrutions at http://blog.discourse.org/2013/04/discourse-as-your-first-rails-app/ and then do the folowing steps

```
vagrant up
vagrant ssh

sudo apt-get update
sudo apt-get install libmysqlclient-dev

git checkout stable
cd plugins/
git clone https://github.com/srcclr/open-core.git
git clone https://github.com/srcclr/security-headers.git
git clone https://github.com/srcclr/csp-reports.git
git clone https://github.com/srcclr/bughunt-leaderboard.git
cd ..
bundle install
bin/rake db:migrate
bin/rails s
```
