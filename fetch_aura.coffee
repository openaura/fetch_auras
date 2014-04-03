#!/usr/bin/env coffee
wget         = require 'wget'
url          = require 'url'
rest         = require 'restler'
async        = require 'async'
argv         = require('minimist')(process.argv.slice(2))
artistId     = argv._[0]
particles    = require './lib/particles'
info         = require './lib/info'
extractors   = {}
urls         = []

usage = ->
  console.log """
              Usage: fetch_aura <artist id>
                options
                  --id_type <id type>: oa:anchor_id, oa:artist_id, musibrainz:gid, defaults to oa:artist_id
                  --type <api request type>: info, particles, defaults to particles
                  --outdir <directory>: dir to write images, defaults to images/
                  --host <hostname>: API host, defaults to api.openaura.com
                  --port <port>: API port, defaults to 80
                  --api_key <apikey>: API key
              """
  process.exit 1

usage() unless artistId

idType = argv.id_type || "oa:artist_id"
type   = argv.type    || "particles"
outdir = argv.outdir  || "#{__dirname}/images"
host   = argv.host    || "api.openaura.com"
port   = argv.port    || 80
apiKey = argv.api_key
extractors['particles'] = particles
extractors['info'] = info 

# special case here.
if host == "api.openaura.com" then v = "v1/" else v =""

uri = "http://#{host}:#{port}/#{v}#{type}/artists/#{artistId}?id_type=#{idType}"
uri += "&api_key=#{apiKey}" if apiKey?

rest.get(uri).on "complete", (result) ->
  urls = extractors[type](result)
  async.parallel(
    for u in urls
      do ->
        get = u
        parsed = url.parse(u)
        file = (parsed.pathname.split '/').slice(-1)[0]
        ->
          download = wget.download(get, "#{outdir}/#{file}")
          download.on 'end', -> console.log "Fetched: #{file}"
          download.on 'error', -> console.log "Error for #{file}"
    , -> console.log 'done')


















