start = () ->
	console.log "start wos called"
	sleep = (milliSeconds) ->
		startTime = new Date().getTime()
		i = 0 
		while new Date().getTime() < startTime + milliSeconds
			i++
	sleep(10000)

	return 'hello start'

upload = () ->
	console.log "upload wos called"
	return 'hello upload'

exports.start = start
exports.upload = upload