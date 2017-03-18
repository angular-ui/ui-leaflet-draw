gulp = require 'gulp'
{log} = require 'gulp-util'
assign = require 'object-assign'
karmaKick = require 'karma-kickoff'
argv = require('yargs').argv

opts =
  configFile: '../../karma.conf.coffee'
  logFn: log

gulp.task 'karma', (done) ->
  karmaKick done, assign {}, opts,
    reporters:['dots', 'coverage']
    singleRun: true

gulp.task 'karmaMocha', (done) ->
  karmaKick(done, opts)

gulp.task 'karmaFiles', (done) ->
  karmaKick done, assign {}, opts,
    appendFiles: argv.files
    lengthToPop: 1
    singleRun: true

gulp.task 'spec', ['karma']
