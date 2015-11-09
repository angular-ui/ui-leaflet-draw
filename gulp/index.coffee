require './tasks/'
gulp = require 'gulp'

gulp.task 'default', gulp.series 'build', 'spec'
