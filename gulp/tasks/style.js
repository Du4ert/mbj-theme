module.exports = function() {
    $.gulp.task('style', function() {
    return $.gulp.src('src/style/main.less')
        .pipe($.gp.if($.env === 'development', $.gp.sourcemaps.init()))
        .pipe($.gp.less())
        .pipe($.gp.autoprefixer())
        .on("error", $.gp.notify.onError({
            title: 'style'
        }))
        .pipe($.gp.if($.env === 'development',$.gp.sourcemaps.write()))
        // .pipe($.gp.if($.env === 'production', $.gp.csso()))
        .pipe($.gulp.dest('styles/'))
        .pipe($.bs.reload({
            stream: true
        }));
    })
}