server '54.248.225.246', user: 'akimu', roles: %w[app db web]

set :ssh_options, keys: '~/.ssh/smartgift_capi_key_rsa'
