namespace :database do
    desc "Run the migrations"
    task :migrate do
        on roles(:all) do
            within release_path do
                execute :php, "artisan migrate -vvv --force"
            end
        end
    end

    desc "Reset the database"
    task :reset do
        on roles(:all) do
            within release_path do
                execute :php, "artisan db:reset -vvv"
            end
        end
    end
end
