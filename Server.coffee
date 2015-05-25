express    = require 'express'

module.exports = class OtterOrNotter
	constructor: ->
		@getEnvironmentVariables()
		@serve()

	getEnvironmentVariables: ->
		@ipaddress = process.env.OPENSHIFT_NODEJS_IP
		@port      = process.env.OPENSHIFT_NODEJS_PORT || 8080

		if typeof @ipaddress == "undefined"
			# Log errors on OpenShift but continue w/ 127.0.0.1 - this
			# allows us to run/test the app locally.
			console.warn 'No OPENSHIFT_NODEJS_IP var, using 127.0.0.1'
			@ipaddress = "127.0.0.1"

	serve: ->
		@app = express()
		@app.use express.json()
		@app.use express.static 'static'

		@app.get '/', (req, res) =>
			res.send 'Hello, world'

		@server = @app.listen @port, @ipaddress, =>
			console.log "#{Date(Date.now())}: Node server started on #{@ipaddress}:#{@port} ..."