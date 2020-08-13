module.exports = function() {
    $.gulp.task('fonts', () => {
       return $.gulp.src(['src/fonts/**/*', 
        //'node_modules/@fortawesome/fontawesome-free/webfonts/*'
    ])
       .pipe($.gulp.dest('fonts'))
    })
}