exec = require("child_process").exec
queryString = require("querystring")
fs = require("fs")
###　開始の処理する関数　###
start = (response) ->
	console.log "start was called"
	body = '<html>'+
    '<head>'+
    '<meta http-equiv="Content-Type" content="text/html; '+
    'charset=UTF-8" />'+
    '</head>'+
    '<body>'+
    '<form action="/upload" method="post">'+
    '<textarea name="text" rows="20" cols="60"></textarea>'+
    '<input type="submit" value="Submit text" />'+
    '</form>'+
    '</body>'+
    '</html>';
	response.writeHead 200,
		"Content-Type": "text/html"
	response.write body
	response.end()
###　アップロードしたデータを処理する関数　###
upload = (response,postData) ->
	console.log "upload wos called"
	console.log "Request handler 'upload' was called."
	response.writeHead 200,
  		"Content-Type": "text/plain"
    #postDataから必要なデータをquerystring モジュールで処理して、レスポンスに書き込む        
	response.write("送信した内容 --> " + queryString.parse(postData).text)
	response.end()

exports.start = start
exports.upload = upload