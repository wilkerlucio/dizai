express = require("express")
routes = require("./routes")
user = require("./routes/user")
http = require("http")
path = require("path")
connectAssets = require("connect-assets")
socketIO = require("socket.io")

app = express()

app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set "view engine", "ejs"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser("your secret here")
  app.use express.session()
  app.use connectAssets()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))

app.configure "development", ->
  app.use express.errorHandler()

app.get "/", routes.index
app.get "/users", user.list

httpServer = http.createServer(app)
wsServer = socketIO.listen(httpServer)

wsServer.on "request", (request) ->

httpServer.listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

