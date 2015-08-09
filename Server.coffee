express    = require 'express'
fs         = require 'fs'
swig       = require 'swig'
yaml       = require 'js-yaml'

module.exports = class Server
	constructor: ->
		@getEnvironmentVariables()
		@getPosts()
		@initSwig()
		@serve()

	getEnvironmentVariables: ->
		@ipaddress    = process.env.OPENSHIFT_NODEJS_IP
		@port         = process.env.OPENSHIFT_NODEJS_PORT || 8080
		@disableCache = process.env.DISABLE_CACHE == '1'

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
			swig.setDefaults locals: posts: @posts

	initSwig: ->
		swig.setDefaults
			cache: if @disableCache then false else 'memory'
			loader: swig.loaders.fs "#{__dirname}/templates"

			swig.setFilter 'lineType', (line) ->
				if typeof line == 'object'
					if line.author and line.text
						'paragraph'
					else if line.type == 'video' and line.source
						'video'
					else if line instanceof Date
						'date'
					else
						'unknown'
				else
					if typeof line == 'string' && line.match /\.(jpg|gif)/
						'image'
					else if typeof line == 'string'
						'location'
					else
						'unknown'

	serve: ->
		@app = express()
		@app.use express.json()
		@app.use express.static 'static'

		@app.get '/', (req, res) =>
			if @disableCache
				@getPosts()

			res.send swig.renderFile "index.swig"

		@app.get '/:slug', (req, res) =>
			if @disableCache
				@getPosts()

			slug = req.params.slug
			if slug of @posts
				res.send swig.renderFile "post.swig", post: @posts[slug]
			else
				res.status(404).send 'Page not found'

		@server = @app.listen @port, @ipaddress, =>
			console.log "#{Date(Date.now())}: Node server started on #{@ipaddress}:#{@port} ..."