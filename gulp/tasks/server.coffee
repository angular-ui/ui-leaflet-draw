server = require 'http-server'
gulp = require 'gulp'
path  = require 'path'

gulp.task 'server', (done) ->
  server.createServer(
    root: path.join __dirname, '../../'
    # robots: true
    # headers:
    #   'Access-Control-Allow-Origin': '*',
    #   'Access-Control-Allow-Credentials': 'true'

  ).listen(8080)
  done()

gulp.task 's', ['server']
