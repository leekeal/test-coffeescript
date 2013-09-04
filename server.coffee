http = require("http")
url = require("url")

start = (route,handle) ->
	onRequest = (request,response) ->
		pathName = url.parse(request.url).pathname
		console.log "Request received"

		content = route(handle,pathName)

		response.writeHead(200,{"Content-Type":"text/plain"})
		response.write(content)
		response.end()
	
	http.createServer(onRequest).listen(8888)
	console.log "Listening on port 3000"


exports.start = start