'use strict';

global.$ = {
    gulp: require('gulp'),
    gp: require('gulp-load-plugins')(),
    bs: require('browser-sync').create(),
    env: process.env.NODE_ENV || 'development',

    path: {
        tasks: require('./gulp/config/tasks.js')
    }
};

$.path.tasks.forEach(function(taskPath) {
    require(taskPath)();
});

$.gulp.task('set-prod', function(done) {
    $.env = process.env.NODE_ENV = 'production';
    done();
});

$.gulp.task('set-dev', function(done) {
    $.env = process.env.NODE_ENV = 'development';
    done();
});

$.gulp.task('build', $.gulp.series(
    $.gulp.parallel('clean', 'set-prod'),
    $.gulp.parallel('img', 'fonts', 'style', 'script:lib', 'script')
));

$.gulp.task('default', $.gulp.series(
    $.gulp.parallel('set-dev'),
    $.gulp.parallel('img', 'fonts', 'style', 'script:lib', 'script'),
    $.gulp.parallel('watch', 'serve')
));
