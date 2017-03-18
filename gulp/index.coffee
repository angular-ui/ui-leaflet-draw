require './tasks/'
gulp = require 'gulp'
series = require 'gulp-sequence2'

gulp.task 'default',  series('build', 'spec')
