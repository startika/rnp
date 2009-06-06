require 'yaml'

begin
  APP_CONFIG = YAML.load(File.read(RAILS_ROOT + "/config/app_config.yml"))
rescue
  puts <<-EOF
    You need to create app_config.yml in your config/ directory.
    Use config/app_config.yml.example as template.
  EOF
  exit(1)
end
