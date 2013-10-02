http = require("http")
url = require("url")

exports.start = (route,handle) ->

	onRequest = (request,response) ->
		postData = ""

		pathName = url.parse(request.url).pathname
		console.log "Request received"
		#设置编码
		request.setEncoding "utf8"
		#监听请求上传事件,并处理数据
		request.addListener "data", (postDataChunk) ->
			postData += postDataChunk
			console.log "Received POST data chunk '" + postDataChunk + "'."
		#监听请求结束时间,把数据交给路由
		request.addListener "end", ->
			route(handle,pathName,response,postData)

	# step 1
	http.createServer(onRequest).listen(3000)
	console.log "Listening on port 3000"