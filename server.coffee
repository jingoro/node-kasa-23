express = require 'express'

app = module.exports = express.createServer()

require("#{__dirname}/app/config")(app)
require("#{__dirname}/app/routes")(app)

app.listen 3000
console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
