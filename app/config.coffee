express    = require 'express'
stylus     = require 'stylus'
nib        = require 'nib'
stitch     = require 'stitch'

module.exports = (app) ->

  root = "#{__dirname}/.."

  app.configure ->
    app.set "views", "#{root}/views"
    app.set "view engine", "jade"
    app.set "view options",
      layout: 'layout.ejs'
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use app.router
    
    # stylus middleware -- must be before static middleware
    app.use stylus.middleware
      src: "#{root}/app"
      dest: "#{root}/public"
      compile: (str, path) ->
        stylus(str)
          .set('filename', path)
          # .set('warn', true)
          # .set('linenos', true)
          # TODO add compression for production mode
          # .set('compress', true)
          # .set('firebug', true)
          .use(nib())
    
    app.use express.static("#{root}/public")

  app.configure "development", ->
    app.use express.errorHandler(
      dumpExceptions: true
      showStack: true
    )

  app.configure "production", ->
    app.use express.errorHandler()

  package = stitch.createPackage
    paths: [ "#{root}/app/web", "#{root}/app/vendor-web" ]

  app.get '/javascripts/application.js', package.createServer()
