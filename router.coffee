### routeを処理する ###
exports.route = (handle,pathName,response,request) ->
		#routeを処理する関数が存在することを判断する。
		if typeof handle[pathName] is 'function'
			#存在する場合postしたデータとresponseのインスタンスを対応している処理関数を代入				
			return handle[pathName](response,request)
		else
			console.log "No request handler found for #{pathName}"
			response.writeHead 404,
 				"Content-Type": "text/plain"
			response.write "404 Not found"
			response.end()