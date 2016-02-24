var Dredd = require('dredd');

var isTesting = process.env.APP_ENV === 'testing';
var dredd = new Dredd({
    server:  isTesting ? 'http://localhost:8000' : 'http://the-project.dev',
    options: {
        'server':    'php artisan serve',
        'path':      ['docs/api/index.apib'],
        'language':  isTesting ? 'vendor/bin/dredd-hooks-php' : 'dredd-hooks-php',
        'hookfiles': ['tests/dredd/hooks.php'],
        'reporter':  ['apiary'],
        'color':     true,
    },
});

dredd.run(function (errors) {
    // ...
});
