# fetch_aura

This is a simple node example which uses the OpenAura API to fetch and
download images.

## Install

```npm install -g fetch_aura```

## Usage

```
Usage: fetch_aura <artist id>
  options
    --id_type <id type>: oa:anchor_id, oa:artist_id, musibrainz:gid, defaults to oa:artist_id
    --type <api request type>: info, particles, defaults to particles
    --outdir <directory>: dir to write images, defaults to images/
    --host <hostname>: API host, defaults to api.openaura.com
    --port <port>: API port, defaults to 80
    --apikey <apikey>: API key
```
