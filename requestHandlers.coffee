queryString = require("querystring")
fs = require("fs")
formidable = require("formidable")
url = require("url")

###　アップロードしたデータを処理する関数　###
exports.index = (response,request) ->
    if request.method.toLowerCase() is 'post'
        form = new formidable.IncomingForm()
        form.parse request, (error,fields,files) ->
            #ファイルを保存する/这里使用的是同步处理文件 所以show可以放在后面
            fs.renameSync files.upload.path,"upload/"+files.upload.name
            console.log files.upload.name + "を保存しました"
            show(response)
    else
        show(response)


show = (response)->
    header = '
    <html　lang="ja">
        <title>写真</title>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=utf8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        </head>
        <body>
            <nav class="navbar navbar-inverse" role="navigation">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">写真</a>
                </div>
                <form action="/" method="post" enctype="multipart/form-data" class="navbar-form navbar-right" role="form">
                    <div class="form-group">
                        <input type="file" name="upload" id="upload">
                    </div>
                    <div class="form-group">
                        <input type="submit" class="btn btn-primary" value="写真を追加" />
                    </div>
                </form>
            </nav>
    '

    footer = '
        </body>
    </html>
    '

    response.writeHead 200,
                "Content-Type": "text/html"
    response.write header 

    fs.readdir "upload/",(error,files)->
                if error
                    console.log "read dir error"
                else
                    response.write '<div class="row">'
                    for file in files
                        # 拡張子をfilenameから取り出す
                        extension = file.match(/[^\.]+$/)[0].toLowerCase()
                        # 拡張子が存在してあるもの出力られる   
                        if extension is 'jpg' or extension is 'gif' or extension is 'jpeg'
                            response.write '<div class="col-xs-6 col-md-3">'+
                                "<img src='/image?filename=#{file}' class='img-thumbnail'/>"+
                                '</div>'
                    response.write '</div>'
                ###  
                因为nodejs是异步,如果不把response.end放在readdir里面,
                readdir执行后马上执行response.end, 就会导致循环里的输出不能写到response里面
                ###

                response.write footer
                response.end()


#写真ファイルを出力      
exports.image = (response,request) ->
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
#cssファイルを出力    
exports.css = (response,request) ->
    #urlを処理する
    urlParsed = url.parse(request.url)
    #urlのqueryを取り出して、ファイル名を明確する
    fileName = queryString.parse(urlParsed.query).filename
    fs.readFile "bootstrap/css/bootstrap.min.css","binary",(error,file)->
        if error
            response.writeHead 500,
                "Content-Type": "text/plain"
            response.write error + "\n"
            response.end()
        else
            response.writeHead 200,
                "Content-Type": "text/css"
            response.write file,"binary"
            response.end()


