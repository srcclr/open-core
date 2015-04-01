# Acess Your Server
------

[Official Guide](https://github.com/discourse/discourse/blob/master/docs/INSTALL-digital-ocean.md#install-discourse)

[Hardware / Software Requirements](https://github.com/discourse/discourse/blob/master/docs/INSTALL.md)

```
ssh root@YOU-IP-ADDRESS
```

# Install Docker / Git

```
wget -qO- https://get.docker.io/ | sh
```

# Install Discourse

Create a `/var/discourse` folder, clone the [Official Discourse Docker Image][https://github.com/discourse/discourse_docker] into it, and make a copy of the config file as `app.yml`:

mkdir /var/discourse
git clone https://github.com/discourse/discourse_docker.git
/var/discourse
cd /var/discourse
cp samples/standalone.yml containers/app.yml

# Edit Discourse Configuration

Edit the Discourse configuration at `app.yml`:

    nano containers/app.yml

We recommend Nano because it works like a typical GUI text editor, just
use your arrow keys.

- Set `DISCOURSE_DEVELOPER_EMAILS` to your email address.

- Set `DISCOURSE_HOSTNAME` to `discourse.example.com`, this means you
  want your Discourse available at `http://discourse.example.com/`.
You'll need to update the DNS A record for this domain with the IP
address of your server.

- Place your mail credentials in `DISCOURSE_SMTP_ADDRESS`,
  `DISCOURSE_SMTP_PORT`, `DISCOURSE_SMTP_USER_NAME`,
`DISCOURSE_SMTP_PASSWORD`. Be sure you remove the comment `#` character
and space from the front of these lines as necessary.

- If you are using a 1 GB instance, set `UNICORN_WORKERS` to 2 and
  `db_shared_buffers` to 128MB so you have more memory room.

After completing your edits, press <kbd>Ctrl</kbd><kbd>O</kbd> then
<kbd>Enter</kbd> to save and <kbd>Ctrl</kbd><kbd>X</kbd> to exit.

# Email Is Important

**Email is CRITICAL for account creation and notifications in Discourse.
If you do not properly configure email before bootstrapping YOU WILL
HAVE A BROKEN SITE!**

- Already have a mail server? Great. Use your existing mail server
  credentials.

- No existing mail server, or you don't know what it is? No problem,
  create a free account on [**Mandrill**][man] (or [Mailgun][gun], or
[Mailjet][jet]), and use the credentials provided in the dashboard.

- For proper email deliverability, you must set the [SPF and DKIM
  records](http://help.mandrill.com/entries/21751322-What-are-SPF-and-DKIM-and-do-I-need-to-set-them-up-)
in your DNS. In Mandrill, that's under Sending Domains, View DKIM/SPF
setup instructions.

  [man]: https://mandrillapp.com
  [jet]: https://www.mailjet.com/pricing
  [gun]: http://www.mailgun.com/

# Install Plugins

Add information about external plugins into `app.yml` into plugin section:

```
hooks:
  after_code:
    - exec:
        cd: $home/plugins
        cmd:
          - git clone https://github.com/discourse/docker_manager.git
          - git clone https://github.com/discourse/discourse-tagging.git
          - git clone https://github.com/Continuous-Security/discourse_stackexchange.git
          - git clone https://github.com/Continuous-Security/discourse_reports.git
          - cp discourse_reports/db/migrate/* ../db/migrate/
```

# Bootstrap Discourse

Save the `app.yml` file, and begin bootstrapping Discourse:

    ./launcher bootstrap app

This command takes about 8 minutes. It is automagically configuring your
Discourse environment.

After that completes, start Discourse:

    ./launcher start app
