namespace :maintenance do
    desc "Enable maintenance mode"
    task :enable do
        on roles(:all) do
            within release_path do
                execute :php, "artisan down"
            end
        end
    end

    desc "Disable maintenance mode"
    task :disable do
        on roles(:all) do
            within release_path do
                execute :php, "artisan up"
            end
        end
    end
end
