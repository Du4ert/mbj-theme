module.exports = function() {
    $.gulp.task('img', function() {
    return $.gulp.src('src/img/**/*')
        .pipe($.gp.if($.env === 'production', $.gp.cache($.gp.image())))
        .pipe($.gulp.dest('img'))
    });
}