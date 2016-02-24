namespace :cache do
    desc 'Get cachetool'
    task :install do
        on roles(:all) do
            within shared_path do
                cachetoolFileExists = capture("if [ -f cachetool.phar ]; then echo 'yes'; fi").chomp

                if cachetoolFileExists != "yes"
                    execute "cd #{shared_path} && curl -sO http://gordalina.github.io/cachetool/downloads/cachetool.phar && chmod +x cachetool.phar"
                else
                    execute "php #{shared_path}/cachetool.phar self-update"
                end
            end
        end
    end

    desc "Clear the entire cache (all cache systems)"
    task :clear do
        on roles(:all) do
            within release_path do
                execute :php, "-r \"opcache_reset();\""
                execute :php, "artisan cache:clear"
                execute :php, "artisan twig:clean"
                execute :php, "#{shared_path}/cachetool.phar opcache:reset --fcgi"
            end
        end
    end
end
