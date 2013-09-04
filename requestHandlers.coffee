exec = require("child_process").exec
start = () ->
	console.log "start wos called"
	content = "empty"
	exec("ls -lah",(error,stdout,stderr) ->
		content = stdout
		console.log content
		)	

	return content

upload = () ->
	console.log "upload wos called"
	return 'hello upload'

exports.start = start
exports.upload = upload