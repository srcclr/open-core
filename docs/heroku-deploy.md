# Basic Heroku deployment

- git clone git@github.com:discourse/discourse.git
- Copy `discourse_repots` into `discourse/plugins`
- Fix .gitignore

*.gitignore*

```diff
- /plugins/*
+ #-/plugins/*

- public/assets
+ # public/assets
```

- Check settings for production env (`config/application.rb`)
- Precompile assets

`SECRET_TOKEN=5310bc16ef6ecfd0 RAILS_ENV=production bundle exec rake assets:precompile`

Also, you'll need to add a commit to get the precompiled assets and
plugins onto Heroku.

```bash
git add public/assets
git push heroku heroku:master
```

