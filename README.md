# HOSE

The HOSE software project aims to help CWU students (and potential CWU students) evaluate housing options. Below is the live webpage:

[HOSE Webpage](https://differences-recovered-nat-extraction.trycloudflare.com/)

## Table of Contents

- [Running Software](#running-software)
  - [Running the Frontend](#running-the-frontend)
    - [System Requirements](#system-requirements)
    - [First-Time Initialization](#first-time-initialization)
    - [Running the Electron Application](#running-the-electron-application)
    - [Using Public Server](#using-public-server)
      - [Endpoints Needed by Frontend](#endpoints-needed-by-frontend)
  - [Running the Backend](#running-the-backend)
    - [System Requirements](#system-requirements-1)
    - [First-Time Initialization](#first-time-initialization-1)
      - [Setting up .env File](#setting-up-env-file)
      - [Setting up OSRM Routing Service](#setting-up-osrm-routing-service)
      - [Setting up Image Service](#setting-up-image-service)
    - [Running Locally](#running-locally)
    - [Testing Succesfull Startup](#testing-succesfull-startup)
- [Hosting Project in Production](#hosting-project-in-production)
  - [Initial Setup](#initial-setup)
  - [Running the Project](#running-the-project)
  - [Accessing Production URL](#accesing-production-url)
  - [Stopping the Server](#stopping-the-server)
- [Updating Database Content](#updating-database-content)
  - [System Requirements](#system-requirements-2)
  - [Bulk Uploads Initial Setup](#bulk-uploads-initial-setup)
  - [Uploading Property](#uploading-property)
    - [Uploading a Single Property](#uploading-a-single-property)
      - [Data format](#data-format)
      - [Performing Upload](#performing-upload)
    - [Bulk Property Uploads](#bulk-property-uploads)
      - [Data Format](#data-format-1)
      - [Performing Upload](#performing-upload-1)
  - [Uploading Property Images](#uploading-property-images)
    - [Image Requirements](#image-requirements)
    - [Uploading a Single Property Image](#uploading-a-single-property-image)
    - [Bulk Property Image Uploads](#bulk-property-image-uploads)
      - [Data Format](#data-format-2)
      - [Performing Upload](#performing-upload-2)
  - [Calculating Distances](#calculating-distances)

# Running Software

In order to run this application, it must first be downloaded. This can be done from github with:

```bash
git clone https://github.com/ameb8/hose
```

Or if using SSH:

```bash
git clone git@github.com:ameb8/hose.git
```

All further instructions for running this project assume you have already cloned the repository and navigated to the project's root directory. After cloning the repository, this can be done with:

```bash
cd hose
```

Additionally, all instructions for running this project assume you have access to a working bash or Zsh shell.

## Running the Frontend

### System Requirements

In order to run the frontend, `Node.js` must first be [installed](https://nodejs.org/en/download) on your system with `npm`. The frontend is very lightweight and can be run on almost any system.

### First-Time Initialization

After `Node.js`, is installed, you can install npm packages. Starting from the project root directory, this can be done with:

```bash
cd frontend
npm install
```

### Running the Electron Application

After first time initialization, the Electron application can subsequently be run with:

```bash
cd frontend
npm start
```

Note that this requires the development server to be running in order to work. However, if you intend on running only the frontend, you can simply rely on the production server to request data. This requires changing the URL from which the frontend requests data to the production server's URL. This can be done by commenting out [Line 1 in this file](https://github.com/Ameb8/hose/blob/master/frontend/map/api.js#L1) and uncommenting [Line 2](https://github.com/Ameb8/hose/blob/master/frontend/map/api.js#L1). After restarting the electron application, the frontend will work without running the backend server locally. 

### Using Public Server

The server is now hosted, and available at [this base url](https://driving-solaris-stewart-visiting.trycloudflare.com). The frontend can query GeoJSON feature list at the `/destinations` endpoint, detailed property data at the `/properties/{PROPERTY_PK}` endpoint, and routing calculations at the `/destinations/{SOURCE_PK}/{DEST_PK}/route?profile={TRANSPORTATION_METHOD}`. In order to avoid malicous bot behavior, rate-limitng allows only 5 requests per minute from a client for all endoints. This can be adjusted if it is causing anyone issues. Additional endpoints exist for write operations, intended only for admins to populate the database in a consistent and standardized manner.

The URL may change periodically until a more permenant hosting solution is found. This document will be updated upon url change. Additionally, the server will periodically go down. In this scenario, running locally will allow testing of API interactions (see below).

#### Endpoints Needed by Frontend:

[GeoJSON Features](https://driving-solaris-stewart-visiting.trycloudflare.com/destinations) (GET)

This endpoint returns all map features in GeoJSON format. It is called once on initial map load.

[Detailed Property Info (change trailing int to any property's ID)](https://driving-solaris-stewart-visiting.trycloudflare.com/properties/56) (GET)

This endpoint is used to query detailed informtion about any property object. The path parameter can be switched to any property objects' ID. If the primry key does not reference valid Property object, the request will fail. The frontend uses this endpoint to display HOSE cards and enable detailed property comparisons.

[Routing Data Between 2 Destinations](https://driving-solaris-stewart-visiting.trycloudflare.com/destinations/10/70/route?profile=BIKE) (GET)

This endpoint returns routing data for travelling between two destination objects. The response includes travel time and distance, as well as travel path in GeoJSON format. The two path parameters are the primary keys of the source and destination objects. The query parameter allows for selection of different travel modes, defaulting to `WALK` if not provided. Valid values are "WALK", "BIKE", or "CAR". 


## Running the Backend

### System Requirements

The backend server can be easily ran if a few requirements are met. Firstly, you must have a recent version of [Docker installed](https://docs.docker.com/get-started/get-docker/). Additionally, the backend has not been tested on a Windows system, however, it may work. On Linux systems, this project is lightweight (except the LLM server), and does not require a powerful machine to run. However, on non-Linux systems (MacOS for example), the system load will be signifiicantly heavier. This is due to Docker Desktop reliance on an internal VM when running on non-Linux systems. While the server itself is lightweight, Docker Desktop has the potential to use a fair amount of RAM depending on your system.

### First-Time Initialization

#### Setting up .env File

This project uses a `.env` file to store project secrets and configuration values. For security, this file is not included in the git repository. However, the file can be created by simply copying the `.env.example` included in the repository. From the project's root directory, this can be done with:

```bash
cp .env.example .env
```

Default `.env.example` values will work correctly for basic running of the software. However, it is highly recomended that you update certain fields for security. Firstly, the default `ADMIN_KEY` should be replaced with a secure key. If this is not done, the enddpoints which are intended for only site admin will be unsecured. A secure key can be generated with the following command:

```bash
openssl rand -base64 32
```

The generated key can be copy and pasted into this environmental variable in the `.env` file:

```env
# Internal API Key for Site Admin
ADMIN_KEY=SUPER_SECRET_HOSE_ADMIN_KEY
```

Note that while `ADMIN_KEY` should be changed, the `INTERNAL_API_KEY` variable is currently unused thus does not need to be changed. Additionally, it is recomended that you change the database credentials for security. This must be done before the project is ran the first time. If the project has been run without updating `.env` values, the following command can be used to reset database content and credentials automatically. While this does delete all database content, it will automatically be re-seeded on the next startup. However, any updates you have made to database content will be lost.

```bash
docker compose down -v
```

The following environmental variables should be updated for security:

```env
DB_USER=username
DB_PASSWORD=password
```

These credentials can later be used to access the database directly. It is important to note that `DB_NAME` an `DB_PORT` must be left as their default values.

#### Setting up OSRM Routing Service

After the preceeding steps have been completed, the software can be ran without errors. However, until OSRM data preprocessing has been completed, the routing feature will not work. The first step to preprocessing the data is to ensure the `preprocess.sh` script has executable permissions. This can be done with:

```bash
chmod +x osrm/scripts/*.sh
```

The following 3 commands will then preprocess data for each OSRM instance. Optionally, a subset of these commands can be run, however, only those specific routing modes will be supported. To initialize all routing services you can run:

```bash
./osrm/scripts/preprocess.sh foot
./osrm/scripts/preprocess.sh bike
./osrm/scripts/preprocess.sh car
```

Due to the small map size included in this repository, most machines will be able to execute this scripts in a couple seconds. The routing services will now be enabled when running the project normally.


#### Setting up Image Service

Because the image URLs included in the repository's data seed are valid, property images will be displayed. However, to allow for uploading new images when running the server, you must [create a Cloudinary account](https://cloudinary.com/signup) and update the following values in the .env file with your own credentials:

```env
# Cloudinary Credentials (Image Service)
CLOUDINARY_CLOUD_NAME=dkmt0rk64
CLOUDINARY_API_KEY=public-key
CLOUDINARY_API_SECRET=private-key
```

Updating these values will not prevent seeded images from displaying, but will allow for uploading new images. See [here](#updating-database-content) for more ionformation on update images and other database content

### Running Locally


After the preceeding steps have been completed once, subsequent runs of the project can be made with:

```bash
make dev
```

This command invokes `docker-compose.yml` and `docker-compose.dev.yml`. The actual commmand executed when you run `make dev` is:

```bash
docker compose -f docker-compose.yml -f docker-compose.dev.yml up --build
```

Note that this may take some time to start up on the initial runs. However, while subsequent runs will be faster, expect the `hose-api` service to take about a minute to start. In order to stop the server, you can press `CTRL + C` in the running terminal. The `make dev` command automatically displays logs in real time, but they can be viewed from the project root directory in any terminal instance with:


```bash
make logs-dev
```

### Testing Succesfull Startup

If the startup process was completed succesfuly, the following API endpoints will be accesable on the same device running the server:

[GeoJSON Features](http://localhost:8080/destinations) (GET)

[Detailed Property Info (change trailing int to any property's ID)](http://localhost:8080/properties/56) (GET)

[Routing Data Between 2 Destinations](http://localhost:8080/destinations/10/70/route?profile=BIKE) (GET)

Additionally, the routing services can be tested directly with:

```bash
./osrm/scripts/test-req-bike.sh
./osrm/scripts/test-req-walk.sh
./osrm/scripts/test-req-foot.sh
```

Succesful output will look something like:

```
Calculating wal time/distance from North Village Cafe to Samuelson Hall with OSRM
Google Maps benchmark result: ~16 minutes / ~0.8 miles
In OSRM units: ~960 seconds / ~1287.5 meters
OSRM results:
{"code":"Ok","routes":[{"legs":[{"steps":[],"distance":1640.6,"duration":445.6,"summary":"","weight":445.6}],"distance":1640.6,"duration":445.6,"weight_name":"duration","weight":445.6}],"waypoints":[{"hint":"iUoAgCxLAIAKAAAAFgAAAAAAAAAAAAAAkcyOQPtWC0EAAAAAAAAAAAoAAAAWAAAAAAAAAAAAAAAGAAAAcc3Q-NZLzQJ4zdD42kvNAgAA7xMXMXG2","distance":0.693497,"name":"","location":[-120.533647,47.008726]},{"hint":"O1YAgD9WAIC7AAAAQQAAAAAAAAAAAAAAwagnQqRDZ0EAAAAAAAAAALsAAABBAAAAAAAAAAAAAAAGAAAAEbfQ-L0uzQLMtdD4wC7NAgAADwAXMXG2","distance":24.709681,"name":"Walnut Mall","location":[-120.539375,47.001277]}]}
```



# Hosting Project in Production

The `docker-compose.prod.yml` file included in this repository supports public hosting of the HOSE Webpage and the backend services. Public exposure is done through the use of cloudflared tunnels. These tunnels automatically use *https* and *TLS* certificates, as well as providing basic *DDoS* protection and bot filtering. Furthermore, the client only sees the *IP* address of Cloudflare's edge network, not the host machine's *IP* address. However, due to lack of domain ownership, the quick tunnel feature is used, resulting in a new URL every time the tunnel containers are restarted.

## Initial Setup

First time initialization can be completed as described in the previous section. This includes creating a valid .env file and preprocessing routing data. However, as it is designed for our specific system, the OSRM service assumes an `ARM` CPU architecture. However, this can be adjusted by removing the image tag from all osrm services in the `docker-compose.prod.yml` file. This is the seciton that needs updated:

```yaml
  # Run OSRM ARM image
  osrm-foot:
    image: osrm-backend-arm
    restart: unless-stopped
  osrm-bike:
    image: osrm-backend-arm
    restart: unless-stopped
  osrm-car:
    image: osrm-backend-arm
    restart: unless-stopped
```

It can be changed to:

```yaml
  # Run OSRM default Docker image
  osrm-foot:
    restart: unless-stopped
  osrm-bike:
    restart: unless-stopped
  osrm-car:
    restart: unless-stopped
```

## Running the Project

Additionally, as the URLs of the servers are partially randomly generated, a few paths must be updated throughout the project. Firtly, the `SERVER_URL` variable in the `.env` file can be changed. This does not affect the webpage or server, but is required for the project's utility and test scripts to function correctly. For the frontend to be able to reach the Rest-API, you must also update the `API_BASE_URL` constant at line 1 in [this frontend file](https://github.com/Ameb8/hose/blob/master/frontend/map/api.js#L1). This process must be repeated every time the server's cloudflared tunnel is restarted.

After setup has been completed, the production build can be started with:

```bash
make prod
```

This will deploy the backend server and the frontend webpage at randomly generated URLs. The cloudflared tunnel services will generate new URLs every time they are restarted. URLs can be found by inspecting the logs. Logs can be viewed with the following command:

```bash
make logs-prod
```

However, you can safely restart any other service without affecting URLs. Utility *Make* commands have been included to make redeployment of the webpage and Rest-API more straightforward. The Webpage container can be restarted with:

```bash
make deploy-frontend
```

This will update the frontend server very quickly, deploying any code updates. However, for changes to be visible, you may initially need to open the webpage in a private browser, to avoid caching old states. Alternatively, the Rest-API can be redeployed with:

```bash
make deploy-api
```

This update can take up to a minute to be up and running.


## Accesing Production URL

As the URL of the production servers change with restarts to tunnel services, it is important to be able to access the URLs. This can be down by inspecting the logs, which can be viewed with `make logs-prod`. The `cloudflared` service will output the base URL of the Rest-API, while the `cloudflared-frontend` will output the webpage's URL. They will both be in the following format:

https:random-text-here.trycloudflare.com

These URLs will be publicly reachable froom any internet-connected machine.

## Stopping the Server

All services can be stopped with the following command:

```bash
make down-prod
```

# Updating Database Content

In order to update database content, you must have the correct `ADMIN_KEY` and `SERVER_URL` values in your `.env` file. If you are running locally, you can set these to your own values. If you intend to contribute data to the production HOSE server, you can contact me at *alexmeb81@outlook.com* to request access to the API-Key.

The database content can be updated manually (either through a database management GUI or SQL commands), but for more reliable and consistent data management, it is recomended that you use admin-endpoints where possible. First, you must ensure the update scripts are executable with the following command:

```bash
chmod +x server/test_requests/scripts/*.sh 
```

These scripts allow for easy uploads of new properties and property images. These scripts read values from the project's `.env` file, however, as the path is created relative to the script locations, they can be invoked from any directory as long as file paths are properly adjusted in the execute command (no changes to scripts needed). 

## System Requirements

Single property or image uploads only require a working bash terminal. However, in order to use the Python bulk upload scripts, you must have `Python3` and `pip` installed on your system.

## Bulk Uploads Initial Setup

Setup begins by navigating to the `test_requests` directory:

```bash
cd server/test_requests
```

To isolate the Python environment, you must create and activate a virtual environment:

```bash
python3 -m venv .venv
source .venv/bin/activate
```

Next, you must install dependencies in the virtual environment

```
pip install -r scripts/requirements.txt
```

The virtual environment can be deactivated with:

```bash
source .venv/bin/activate
```

Future runs will require the virtual environment to be rectivated. 


## Uploading Property

### Uploading a Single Property

#### Data format

To upload a single property, you can create a JSON file in the same structure as included in the `hose/server/test_requests/synthetic_data/property.json` file, seen [here](https://github.com/Ameb8/hose/blob/master/server/test_requests/synthetic_data/property.json). The correct format can be seen below:

```json
{
  "name": "Example Residence Hall",
  "propertyType": "DORM",
  "description": "A sample dormitory property in Ellensburg. Conveniently located near campus facilities with all amenities included.",

  "contactPhone": "5095551234",
  "contactEmail": "housing@example.edu",

  "latitude": 46.99618,
  "longitude": -120.54863,

  "street": "123 Example St.",
  "city": "Ellensburg",
  "state": "WA",
  "zip": "98926",

  "unitTypes": [
    {
      "name": "Standard Double",
      "bedrooms": 2,
      "bathrooms": 0,
      "rentCents": 100000,
      "description": "Double bedroom unit with shared bathroom"
    },
    {
      "name": "Double En Suite",
      "bedrooms": 2,
      "bathrooms": 1,
      "rentCents": 120000,
      "description": "Double bedroom unit with private bathroom"
    }
  ]
}
```

#### Performing Upload

Next, the file you created can be passed as argument to the `prop-post.sh` script with the following command from project root directory. You can replace the filepath with your own `.json` file.

```bash
./server/hose/scripts/prop-post.sh server/hose/scripts/synthetic_data/property.json
```

### Bulk Property Uploads

#### Data Format

This repository offers a Python script to upload multiple properties in a single run. The data format is similar to single property uploads, however, instead of  one JSON object containing all fields for a single property, you input an object containing a `properties` list of JSON objects. Each JSON object in the `properties` array is formatted identically to single property uploads. The exact data format can be seen [here](https://github.com/Ameb8/hose/blob/master/server/test_requests/synthetic_data/properties_bulk.json).

#### Performing Upload

After navigating to the `test_requests` folder with `cd server/test_requests`, you must activate the virtual environment. Assuming your data is at the same path as the synthetic example data, you can perform the upload with:

```bash
python scripts/upload_props.py synthetic_data/properties_bulk.json
```

The uploads themeselves happen quickly, however, there is a 10 second delay between them to avoid rate-limiting. Additionally, if an upload fails for any reason, it will not prevent other uploads from being attempted. 

## Uploading Property Images

The `img-post.sh` script can be used to upload new images for any property. However, in order for this to work, you must create a Cloudinary account and update `.env` credentials as discussed [in a previous section](#setting-up-image-service).

### Image Requirements

The HOSE software supports the following image formats:

  - .png
  - .jpg
  - .jpeg

Images are restricted to a maximum size of *5MB*. Additionally, it is recomended that uploaded images are high-resolution and in landscape-style dimensions. However, exact image dimensions are not enforced, but adherence to this will ensure property images appear nicely on the frontend.

### Uploading a Single Property Image

In order to upload a single property image, you must first identify the property's primary key. This can be done by inspecting the database content manually or by using the `id` field from the `/properties` endpoint, found [here](http://localhost:8080/properties) if running in development mode. 

Next, an image meeting the requirements must be found. Assuming you are uploading an image at path `hose/server/test_requests/payloads/example_img.png` for a property with a primary key of 1, you can upload the image with:

```bash
./server/hose/scripts/img-post.sh 1 server/hose/scripts/payloads/example_img.png
```

### Bulk Property Image Uploads

#### Data Format

Bulk image uploads require a specific directory structure containing images, as seen below:

```
synthetic_data/image_dir
├── apt-1_1
│   ├── image_1_.jpeg
│   ├── image_2_.jpg
│   └── image_3.png
├── apt-2_2
│   └── image.jpeg
└── apt-3_3
    ├── 1.jpg
    └── 2.jpg
```

Each subdirectory in the directory you pass must end with an underscore, followed by the primary key of a property. Any character can appear before the underscore without causing problems, including underscores. Additionally, the filenames of the images themeselves do not matter. Directories can contain any number of images, with empty directories being automatically skipped. However, directories should not contain non-compatible or non-image files. All requirements for individual images still apply. 

#### Performing Upload

After navigating to the `test_requests` folder with `cd server/test_requests`, you must activate the virtual environment. Assuming you have a correctly formatted directory `imaage_dir` within `test_requests/synthetic_data`, you can perform the upload with:

```bash
python3 scripts/upload_images.py synthetic_data/image_dir
```

Failed uploads will not prevent other uploads from being attempted. Note that the scirpt sets a 10 second delay between uploads to avoid rate-limiting restrictions.

## Calculating Distances

The database stores distance and time walking to the nearest bus stop and CWU location for each property. However, this action must be triggered manually. To do this for an individual property, you must first identify its' primary key. Next, from the project's root directory, this can be done with:

```bash
./server/test_requests/scripts/calc-nearest.sh 1
```

This can be done for any property by replacing the argument with another property's primary key. To make this calculation for all properties, this can be done with:

```bash
./server/test_requests/scripts/calc-nearest-all.sh
```

Even when calculating for all properties, this can be done very quickly, taking only a few seconds on most machines.

