RAILS_GEM_VERSION = '2.2.2' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')
Rails::Initializer.run do |config|
  config.log_level = :debug
  config.cache_classes = false
  config.whiny_nils = true
  config.load_paths << "#{File.dirname(__FILE__)}/../../../lib/"
  config.load_paths << "#{Rails.root}/../../app/models"
  config.controller_paths << "#{Rails.root}/../../app/controllers"

  config.plugins = [ :awesome_nested_set,:all]
  config.plugin_paths = ["#{RAILS_ROOT}/lib/plugins", "#{RAILS_ROOT}/vendor/plugins"]
  config.gem "has_many_polymorphs"
end

#Dependencies.log_activity = true
