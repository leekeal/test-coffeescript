queryString = require("querystring")
fs = require("fs")
formidable = require("formidable")
###　開始の処理する関数　###
exports.start = (response) ->
	console.log "start was called"
	body = '<html>'+
    '<head>'+
    '<meta http-equiv="Content-Type" content="text/html; '+
    'charset=UTF-8" />'+
    '</head>'+
    '<body>'+
    '<form action="/upload" method="post" enctype="multipart/form-data">'+
    '<input type="file" name="upload">'+
    '<input type="submit" value="Upload file" />'+
    '</form>'+
    '</body>'+
    '</html>';
	response.writeHead 200,
		"Content-Type": "text/html"
	response.write body
	response.end()
###　アップロードしたデータを処理する関数　###
exports.upload = (response,request) ->
    console.log "Request handler 'upload' was called."
    form = new formidable.IncomingForm()
    form.parse request, (error,fields,files) ->
        fs.renameSync files.upload.path,"upload/test.png"
    	response.writeHead 200,
            "Content-Type": "text/html"
        response.write "received image:<br/>" 
        response.write "<img src='/show' />"
    	response.end()

exports.show = (response) ->
    console.log "Request handler 'show' was called"
    fs.readFile "upload/test.png","binary",(error,file)->
        if(error)
            response.writeHead 500,
                "Content-Type": "text/plain"
            response.write error + "\n"
            response.end()
        else
            response.writeHead 200,
                "Content-Type": "image/png"
            response.write file,"binary"
            response.end()


