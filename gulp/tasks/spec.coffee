gulp = require 'gulp'
Karma = require('karma').Server
open  = require 'open'
{log} = require 'gulp-util'

karmaRunner = (done, karmaConf = require.resolve('../../karma.conf.coffee')) ->
  log '-- Karma Setup --'
  try
    server = new Karma
      configFile: karmaConf
      singleRun: true, (code) ->
        log "Karma Callback Code: #{code}"
        done(code)
    server.start()
  catch e
    log "KARMA ERROR: #{e}"
    done(e)

gulp.task 'karma', (done) ->
  karmaRunner(done)

gulp.task 'spec', gulp.parallel 'karma'

doOpen = (name = '') -> (done)->
  open "dist/coverage/lib#{name}/index.html", 'Google Chrome', done

gulp.task 'coverage', doOpen()
