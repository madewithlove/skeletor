<?php
namespace App\Console\Commands;

use Arrounded\Commands\RemigrateCommand;

class RemigrateDatabase extends RemigrateCommand
{
    /**
     * The console command name.
     *
     * @var string
     */
    protected $name = 'db:remigrate';
}
