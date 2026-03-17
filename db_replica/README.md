# First Time Setup

These steps must be completed the first time this database is initialized. For future starts, first time setup can be skipped.

1. **Download, install, and start Docker**

2. **Extract the zip into a folder and enter it:**

```bash
unzip db_replica.zip -d db_replica
cd db_replica
```

3. **Make the script executable:**

```bash
chmod +x update.sh
```

Setup is now complete, and the database can be started normally as follows:

# Restarting DB or Updating Content

The following command can be run, and will start a database exactly matching `data/hose_db.sql`. This command can be run to overwrite the database content with a new dump file, or to restart a stopped database. If manual changes to DB content are made, this command will overwrite changes. Additionally, the database will automatically start whenever Docker is run. if manually stopped, it wll not rerun automatically,

1. **Run Update Script**:

    From the Root folder you unzipped:

```bash
./update.sh
```

2. Wait for script to complete:

    This can take a while, especially the first time it is run. If script is successful, you should get output like:

```bash
Database replica ready
You can connect to the replica database locally using:
-------------------------------------------
Host: localhost
Port: 5432
Database: hose_db_replica
User: postgres_user
Password: postgres_password
-------------------------------------------
Example: psql -h localhost -U postgres_user -d hose_db_replica
```

# Updating DB Content

To update the data, you only need to overwrite `data/hose_db.sql` with a new dump file, then start it normally with the `update.sh` script. The dump name must exactly match the original for the script to work.