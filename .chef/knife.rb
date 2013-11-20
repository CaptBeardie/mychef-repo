current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "rmusaritolo"
client_key               "#{current_dir}/rmusaritolo.pem"
validation_client_name   "rocco-test-validator"
validation_key           "#{current_dir}/rocco-test-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/rocco-test"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]
