require './spec.coffee'
gulp = require 'gulp'

gulp.task 'dist', gulp.series 'build'
