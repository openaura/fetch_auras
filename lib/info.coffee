module.exports = (json) ->
  urls = []
  addUrl = (el) ->
    if (m = el.media.slice(-1)[0])
      urls.push m.url
      
  addUrl(json['profile_photo'])
  for e in json['cover_photo']
    addUrl(e)

  urls    
    
