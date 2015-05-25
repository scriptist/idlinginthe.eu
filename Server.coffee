express    = require 'express'
fs         = require 'fs'
swig       = require 'swig'
yaml       = require 'js-yaml'

module.exports = class Server
	constructor: ->
		@getEnvironmentVariables()
		@getPosts()
		@getTemplates()
		@serve()

	getEnvironmentVariables: ->
		@ipaddress = process.env.OPENSHIFT_NODEJS_IP
		@port      = process.env.OPENSHIFT_NODEJS_PORT || 8080

		if typeof @ipaddress == "undefined"
			# Log errors on OpenShift but continue w/ 127.0.0.1 - this
			# allows us to run/test the app locally.
			console.warn 'No OPENSHIFT_NODEJS_IP var, using 127.0.0.1'
			@ipaddress = "127.0.0.1"

	getPosts: ->
		@posts = {}
		postFiles = fs.readdirSync 'posts'
		postFiles.forEach (postFile) =>
			data = yaml.safeLoad fs.readFileSync("posts/#{postFile}", 'utf8')
			@posts[data.slug] = data

	getTemplates: ->
		swig.setDefaults({ loader: swig.loaders.fs(__dirname + '/templates') })
		@templates =
			index: swig.compileFile 'index.swig'
			posts: swig.compileFile 'post.swig'

	serve: ->
		@app = express()
		@app.use express.json()
		@app.use express.static 'static'

		@app.get '/', (req, res) =>
			res.send @templates.index posts: @posts

		@app.get '/:slug', (req, res) =>
			slug = req.params.slug
			if slug of @posts
				res.send @templates.posts posts: @posts, post: @posts[slug]
			else
				res.status(404).send 'Page not found'

		@server = @app.listen @port, @ipaddress, =>
			console.log "#{Date(Date.now())}: Node server started on #{@ipaddress}:#{@port} ..."