<?php

namespace App\Providers;

use App\Http\Composers\LayoutComposer;
use Illuminate\Support\ServiceProvider;
use Illuminate\View\Factory;

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
     * @param Factory $view
     */
    public function boot(Factory $view)
    {
        $view->composers([
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
