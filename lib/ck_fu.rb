module Forge38
  def ck_fu(options={})
    return "" if (options.has_key?(:if) ? !options[:if] : Rails.production?)
    separator = options[:separator] || "&sect;"
    content_tag :div, :id => 'ck_fu', :class => Rails.environment do
      text = "Env: #{Rails.environment.titlecase}"
      text += " #{separator} Current DB: #{ActiveRecord::Base.connection.current_database}" if ActiveRecord::Base.connection.respond_to?(:current_database)
      text += " #{separator} Current DB: #{ActiveRecord::Base::configurations[RAILS_ENV]['dbfile']}" if ActiveRecord::Base::configurations[RAILS_ENV]['adapter'] == 'sqlite3'
      text += " #{separator} Revision: #{deployed_revision}" if deployed_revision.present? && (options[:revision].nil? || options[:revision])
      text += " #{separator} Deployed: #{deployed_date}" if deployed_date.present? && (options[:date].nil? || options[:date])
      (options[:links] || []).each do |link|
        text += " #{separator} #{link_to link[0], link[1]}"
      end
      text
    end
  end
  
  def deployed_revision
    file = RAILS_ROOT + '/REVISION'
    File.exists?(file) ? File.open(file).read.strip : nil      
  end
  
  def deployed_date
    file = RAILS_ROOT + '/DATE'
    File.exists?(file) ? File.open(file).read.strip : nil
  end
end

module Rails
  def self.environment
    ENV['RAILS_ENV'].to_s.downcase
  end
  
  def self.production?
    environment == 'production'
  end
end