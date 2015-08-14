# How to restore backups

- Login as a system user
- Open the `admin/backups` page
- Upload your backup using UI
- Make sure you have valid `schema_migrations` data on the backup
- Click on Restore button

# How to fix schema migrations

- Extract all files from `tar.gz` backup
- Open `dump.sql` and find the following line:

```
COPY schema_migrations (version) FROM stdin;
20120311163914
20120311164326
...
```
- Make sure you have the following numbers at the list or you could add
  them into the bottom of the list:

```
20150211133824
20150212165422
20150212192210
20150213163410
20150225131740
```

- Save the `dump.sql` and create a new `.tar.gz` archive
