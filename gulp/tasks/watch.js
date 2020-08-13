module.exports = function() {
    $.gulp.task('watch', function() {
        $.gulp.watch('**/*.{tpl,php}',  $.gulp.series('reload'));
        $.gulp.watch('src/style/**/*.less', $.gulp.series('style'));
        $.gulp.watch('src/js/main.js', $.gulp.series('script'));
        $.gulp.watch('src/img/**/*', $.gulp.series('img'));
    })

}