### Start File ###
server = require("./server")
router = require('./router')
requestHandlers = require('./requestHandlers')

#route
handle = 
	"/": requestHandlers.start
	"/start": requestHandlers.start
	"/upload": requestHandlers.upload
	"/image": requestHandlers.image

# Service start,port is 3000
server.start(router.route,handle);
