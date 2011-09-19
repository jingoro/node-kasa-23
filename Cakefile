stitch        = require 'stitch'
uglifyjs      = require 'uglify-js'
fs            = require 'fs'
sys           = require 'sys'
child_process = require 'child_process'

system = (cmd, args) ->
  proc = child_process.spawn(cmd, args)
  proc.stderr.on 'data', (data) ->
    sys.print data
  proc.stdout.on 'data', (data) ->
    sys.print data
  proc.on 'exit', ->
    process.exit 0

task 'test', 'run all tests', ->
  system "#{__dirname}/node_modules/vows/bin/vows"

task 'server', 'run development server', ->
  system 'nodemon', ["#{__dirname}/server.coffee"]

task 'build', 'build production js/css', ->
  
  # TODO move to configuration
  stitchPaths = [ "#{__dirname}/app/web", "#{__dirname}/app/vendor-web" ]
  outputPath  = "#{__dirname}/public/javascripts/application.min.js"
  
  package = stitch.createPackage
    paths: stitchPaths

  package.compile (error, source) ->
    
    ast = uglifyjs.parser.parse source
    ast = uglifyjs.uglify.ast_mangle  ast
    ast = uglifyjs.uglify.ast_squeeze ast
    output = uglifyjs.uglify.gen_code ast
    
    fs.writeFile outputPath, output, (error) ->
      throw error if error
      console.log "Generated #{outputPath}"
