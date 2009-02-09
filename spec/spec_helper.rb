begin
  file = File.expand_path(File.dirname(__FILE__) + '/../../../../spec/spec_helper')
  require file
rescue LoadError
  puts "You need to install rspec in your base app"
  exit
end

plugin_spec_dir = File.dirname(__FILE__)
ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/debug.log")