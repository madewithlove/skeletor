set :stage, :staging

server 'foo.com', user: 'forge', roles: %w{web}

set :branch, 'master'
set :deploy_to, '/var/www/h10915/sites/www/htdocs'
