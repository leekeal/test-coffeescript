### Start File ###
server = require("./server")
router = require('./router')
requestHandlers = require('./requestHandlers')

#route
handle = 
	"/": requestHandlers.index
	"/bootstrap/css/bootstrap.min.css": requestHandlers.css
	"/image": requestHandlers.image

# Service start,port is 3000
server.start(router.route,handle);
