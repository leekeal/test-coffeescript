这样一来，当请求http://localhost:8888/start的时候，会花10秒钟的时间才载入，而当请求http://localhost:8888/upload的时候，会立即响应，纵然这个时候/start响应还在处理中。