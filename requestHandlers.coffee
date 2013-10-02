queryString = require("querystring")
fs = require("fs")
formidable = require("formidable")
url = require("url")
# sys = require("util")
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
    if request.method.toLowerCase() is 'post'
        form = new formidable.IncomingForm()
        form.parse request, (error,fields,files) ->
            #ファイルを保存する
            fs.renameSync files.upload.path,"upload/"+files.upload.name
            console.log files.upload.name + "を保存しました"
        	response.writeHead 200,
                "Content-Type": "text/html"
            response.write "received image:<br/>" 
            fs.readdir "upload/",(error,files)->
                if error
                    console.log "read dir error"
                else
                    for file in files
                        response.write "<img src='/image?filename=#{file}'/>"
                ###  
                因为nodejs是异步,如果不把response.end放在readdir里面,
                readdir执行后马上执行response.end, 就会导致循环里的输出不能写到response里面
                ###
                response.end()
    else
        response.writeHead 500,
            "Content-Type": "text/plain"
        response.write 'アップロードするファイルを選んでいます'
        response.end()

exports.image = (response,request) ->
    console.log "Request handler 'show' was called"
    #urlを処理する
    urlParsed = url.parse(request.url)
    #urlのqueryを取り出して、ファイル名を明確する
    fileName = queryString.parse(urlParsed.query).filename
    fs.readFile "upload/#{fileName}","binary",(error,file)->
        if error
            response.writeHead 500,
                "Content-Type": "text/plain"
            response.write error + "\n"
            response.end()
        else
            response.writeHead 200,
                "Content-Type": "image/png"
            response.write file,"binary"
            response.end()


