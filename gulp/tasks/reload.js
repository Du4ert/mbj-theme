module.exports = function() {
    $.gulp.task('reload', function(done) {
    $.bs.reload();
    done();
    })
}