<?php
use Dredd\Hooks;
use Illuminate\Contracts\Console\Kernel;

require __DIR__.'/../../vendor/autoload.php';
$app = require __DIR__.'/../../bootstrap/app.php';
$app->make(Kernel::class)->bootstrap();

// Test environment preparation
//////////////////////////////////////////////////////////////////////

Hooks::beforeEach(function (&$transaction) use ($app) {
    $app->make('db')->beginTransaction();
});

Hooks::afterEach(function (&$transaction) use ($app) {
    $app->make('db')->rollback();
});
