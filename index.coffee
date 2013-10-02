### Start File ###
server = require("./server")
router = require('./router')
requestHandlers = require('./requestHandlers')

#route
handle = 
	"/": requestHandlers.start
	"/start": requestHandlers.start
	"/upload": requestHandlers.upload
	"/show": requestHandlers.show

# Service start,port is 3000
server.start(router.route,handle);
