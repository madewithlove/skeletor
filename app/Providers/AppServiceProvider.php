<?php

namespace App\Providers;

use App\Http\Composers\LayoutComposer;
use Illuminate\Support\Facades\View;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * @var array
     */
    protected $developmentProviders = [
        \Laracasts\Generators\GeneratorsServiceProvider::class,
        \Barryvdh\Debugbar\ServiceProvider::class,
        \Barryvdh\LaravelIdeHelper\IdeHelperServiceProvider::class,
    ];

    /**
     * Bootstrap any application services.
     *
     */
    public function boot()
    {
        View::composers([
           LayoutComposer::class => '_layouts/global',
        ]);
    }

    /**
     * Register any application services.
     */
    public function register()
    {
        if (config('app.debug')) {
            foreach ($this->developmentProviders as $provider) {
                $this->app->register($provider);
            }
        }
    }
}
