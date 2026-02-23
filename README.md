# HOSE

[HOSE Webpage](https://explicit-streaming-merit-guru.trycloudflare.com)

## For Development

### Using Public Server

The server is now hosted, and available at [this base url](https://bestsellers-navigate-bone-this.trycloudflare.com). The frontend can query GeoJSON feature list at the `/destinations` endpoint, detailed property data at the `/properties/{PROPERTY_PK}` endpoint, and routing calculations at the `/destinations/{SOURCE_PK}/{DEST_PK}/route?profile={TRANSPORTATION_METHOD}`. In order to avoid malicous bot behavior, rate-limitng allows only 5 requests per minute from a client for all endoints. This can be adjusted if it is causing anyone issues. Additionl endpoints exist for write operations, intended only for admins to populate the database in a consistent and standardized manner.

The URL may change periodically until a more permenant hosting solution is found. This document will be updated upon url change. Additionally, the server will periodically go down. In this scenario, running locally will allow testing of API interactions (see below).

#### Endpoints Needed by Frontend:

[GeoJSON Features](https://bestsellers-navigate-bone-this.trycloudflare.com/destinations) (GET)

This endpoint returns all map features in GeoJSON format. It is called once on initial map load.

[Detailed Property Info (change trailing int to any property's ID)](https://bestsellers-navigate-bone-this.trycloudflare.com/properties/1) (GET)

This endpoint is used to query detailed informtion about any property object. The path parameter can be switched to any property objects' ID. If the primry key does not reference  valid Property object, the request will fail. The frontend uses this endpoint to display HOSE cards and enable detailed property comparisons.

[Routing Data Between 2 Destinations](https://bestsellers-navigate-bone-this.trycloudflare.com/destinations/1/10/route?profile=WALK) (GET)

This endpoint returns routing data for travelling between two destination objects. The response includes travel time and distance, as well as travel path in GeoJSON format. The two path parameters are the primary keys of the source and destination objects. The query parameter allows for selection of different travel modes, defaulting to `WALK` if not provided. Valid values are "WALK", "BIKE", or "CAR". 

### Running Locally


If the server is not currently up and running, the project must be run locally to test API interactions. If Docker is installed, this project is very easy to run locally.  After installing Docker, you can clone the repository and navigate to the root directory with:

```bash
git clone https://github.com/ameb8/hose
cd hose
```

Next, a .env file must be created to store project config values. a .env file has been posted in the github channel on discord, or contact developers for access.

The following database config values in the resulting `.env` file can optionally be modified (this is not required):

```bash
# PostgreSQL config
DB_USER=username
DB_PASSWORD=password
DB_NAME=hose_db
```

Now, the project can simply be run with:

```bash
make dev
```

Logs from all running services can be viewed with:

```bash
make logs-dev
```

The initial run may take some time to build the container images, but subsequent runs will be faster. However, expect the server to take up to a minute to start up. A webpage showing results of an API call to the server can be accessed at [http://localhost:5173](http://localhost:5173). The page will automatically reload with code changes. On the same device in which the software was run, the rest endpoints required by the frontend are now:

[GeoJSON Features](http://localhost:8080/destinations) (GET)

[Detailed Property Info (change trailing int to any property's ID)](http://localhost:8080/properties/1) (GET)



