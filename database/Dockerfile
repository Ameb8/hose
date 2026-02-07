FROM postgres:15

RUN apt-get update && \
    apt-get install -y postgis postgresql-15-postgis-3 && \
    rm -rf /var/lib/apt/lists/*
