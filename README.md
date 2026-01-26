# HOSE

## For Development

### Running Locally

After cloning this git repository into your local files, a .env file must be created. `.env.example` can be copied exactly, but the resulting file must be named `.env` exactly in the project root. For example, running the following command from the project root will create a valid `.env` file:

```bash
cp .env.example .env
```

The following database config values in the resulting `.env` file can optionally be modified:

```bash
# PostgreSQL config
DB_USER=username
DB_PASSWORD=password
DB_NAME=hose_db
```

Now, the project can simply be run with:

```bash
docker compose up
```

The initial run may take some time to build the container images, but subsequent runs will be faster. However, expect the server to take up to a minute to start up. A webpage showing results of an API call to the server can be accessed at [http://localhost:5173](http://localhost:5173). The page will automatically reload with code changes. 
