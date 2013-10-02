http = require("http")
url = require("url")

exports.start = (route,handle) ->

	onRequest = (request,response) ->
		pathName = url.parse(request.url).pathname
		console.log "#{pathName}のrequestを受けました"
		route(handle,pathName,response,request)

	# step 1
	http.createServer(onRequest).listen(3000)
	console.log "Listening on port 3000"