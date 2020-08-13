module.exports = function() {
    $.gulp.task('clean', function() {
        $.gp.cache.clearAll()
        return $.gulp.src(['js/*', 'styles/*', 'fonts/*', 'img/*'], {read: false})
        .pipe($.gp.clean())
    })
}