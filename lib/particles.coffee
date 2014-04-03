module.exports = (json) ->
  urls = []
  for el in json.particles
    if (m = el.media.slice(-1)[0])
      urls.push m.url
  urls    
    
