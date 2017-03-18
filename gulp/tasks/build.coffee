gulp = require 'gulp'
gulpif = require 'gulp-if'
coffeelint = require 'gulp-coffeelint'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
{log} = require 'gulp-util'
insert = require 'gulp-insert'
ap = require 'gulp-wrap'
replace = require 'gulp-replace'
insert = require 'gulp-insert'
jf = require 'jsonfile'
wrap = require 'gulp-wrap'
ngAnnotate = require 'gulp-ng-annotate'
require './clean.coffee'

date = new Date()

pkgFn = ->
  jf.readFileSync 'package.json' #always get latest!

header = ->
  ourPackage = pkgFn()
  """
  /**
   *  #{ourPackage.name}
   *
   * @version: #{ourPackage.version}
   * @author: #{ourPackage.author}
   * @date: #{date.toString()}
   * @license: #{ourPackage.license}
   */\n
   """

build = (source, out = 'index.js') ->
  gulp.src source
  .pipe gulpif(/[.]coffee$/,coffeelint())
  .pipe gulpif(/[.]coffee$/,coffeelint.reporter())
  .pipe gulpif(/[.]coffee$/,coffee(require '../coffeeOptions.coffee').on('error', log))
  .pipe concat out
  .pipe(wrap src: 'src/wrap/dist.js')
  .pipe ngAnnotate()
  .pipe insert.prepend(header())
  .pipe gulp.dest 'dist'

gulp.task 'build', ['clean'], ->
  build [
    'src/leafletDrawEvents.coffee'
    'src/*.coffee'
  ], 'ui-leaflet-draw.js'
