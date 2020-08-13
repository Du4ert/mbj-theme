module.exports = function() {
    $.gulp.task('serve', function() {
        $.bs.init({
            proxy:'localhost',
            port:3000,
            open: false,
            online: true,
            //tunnel: 'test'
    });
    });
}