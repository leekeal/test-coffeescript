http = require("http")
url = require("url")

start = (route,handle) ->
	onRequest = (request,response) ->
		postData = null

		pathName = url.parse(request.url).pathname
		console.log "Request received"

		request.setEncoding "utf8"
		request.addListener "data", (postDataChunk) ->
			postData += postDataChunk
			console.log "Received POST data chunk '" + postDataChunk + "'."

		request.addListener "end", ->
			route(handle,pathName,response,postData)

	
	http.createServer(onRequest).listen(8888)
	console.log "Listening on port 3000"


exports.start = start