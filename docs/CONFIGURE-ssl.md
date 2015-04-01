# Buy a SSL Certificate

Go to [namecheap](https://www.namecheap.com) or some other SSL cert provider and purchase a SSL
cert for your domain. Follow all the step documented by them to generate
private key and CSR and finally get your cert. I used the apache
defaults, they will work fine.

Keep your private key and cert somewhere safe.

# Place the Certificate and Key

Get a signed cert and key and place them in the
`/var/discourse/shared/standalone/ssl/` folder

Private key is:

`/var/discourse/shared/standalone/ssl/ssl.key`

Cert is

`/var/discourse/shared/standalone/ssl/ssl.crt`

File names are critical do not stray from them or your nginx template
will not know where to find the cert.

Have a look at your app.yml configuration file to see where the shared
folder is mounted.

```
volumes:
  - volume:
      host: /var/discourse/shared/standalone
      guest: /shared
```

In essence the files must be located at `/shared/ssl/ssl.key`
`/shared/ssl/ssl.crt` inside the container.

# Configure NGINX

Add a reference to the nginx ssl template from your app.yml
configuration file:

```
templates:
  - "templates/postgres.template.yml"
  - "templates/redis.template.yml"
  - "templates/sshd.template.yml"
  - "templates/web.template.yml"
  - "templates/web.ssl.template.yml"
```

# Configure your Docker Container

Tell your container to listen on SSL

```
expose:
  - "80:80"
  - "2222:22"
  - "443:443"
```

# Bootstrap your Docker Container

Rebuild your app

```
./launcher rebuild app
```

# Troubleshooting

Be sure to read through the logs using

```
./launcher logs app
```

If anything goes wrong.
