namespace :application do
    desc "Scans the application for annotations"
    task :annotations do
        on roles(:all) do
            within release_path do
                execute :php, 'artisan route:scan'
                execute :php, 'artisan model:scan'
                execute :php, 'artisan event:scan'
            end
        end
    end

    desc "Caches parts of the application"
    task :cache do
        on roles(:all) do
            within release_path do
                execute :php, 'artisan api:cache'
            end
        end
    end

    desc "Builds the assets"
    task :assets do
        on roles(:all) do
            within release_path do
                execute :php, 'artisan laroute:generate'
                execute :npm, "run build:production"
            end
        end
    end
end
