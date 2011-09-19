module.exports = (app) ->
  
  app.get '/', (req, res) ->
    res.render 'index', title: 'Express'

  app.get "/foo", (req, res) ->
    throw new Error('foox')
