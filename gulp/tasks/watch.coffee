# /*==================================
# =            Watch Task            =
# ==================================*/

gulp   = require 'gulp'
config = require '../config'

gulp.task 'watch', ['setWatch', 'browserSync'], ->
  gulp.watch 'app/*.html',                ['html']
  gulp.watch 'app/**/*.haml',             ['haml']
  gulp.watch 'app/stylesheets/**/*.sass', ['sass']
  gulp.watch 'app/assets/**/*',           ['images']