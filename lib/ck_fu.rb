module Forge38
  def ck_fu(options={})
    return "" if (options.has_key?(:if) ? !options[:if] : Rails.env.production?)
    separator = html_safe(options[:separator] || "&sect;")
    content_tag :div, :id => 'ck_fu', :class => Rails.env do
      text = "Env: #{Rails.env.titlecase}"
      if current_database_name
        text += " #{separator} Current DB: #{current_database_name}"
      end
      text += " #{separator} Revision: #{deployed_revision}" if deployed_revision.present? && (options[:revision].nil? || options[:revision])
      text += " #{separator} Deployed: #{deployed_date}" if deployed_date.present? && (options[:date].nil? || options[:date])
      (options[:links] || []).each do |link|
        text += " #{separator} #{link_to link[0], link[1]}"
      end
      html_safe(text)
    end
  end

  def deployed_revision
    file = Rails.root + '/REVISION'
    File.exists?(file) ? File.open(file).read.strip : nil
  end

  def deployed_date
    file = Rails.root + '/DATE'
    File.exists?(file) ? File.open(file).read.strip : nil
  end

  def html_safe(string)
    string.respond_to?(:html_safe) ? string.html_safe : string
  end

  def current_database_name
    if defined?(ActiveRecord::Base)
      return ActiveRecord::Base.connection.current_database if ActiveRecord::Base.connection.respond_to?(:current_database)
      return ActiveRecord::Base::configurations[Rails.env]['dbfile'] if ActiveRecord::Base::configurations[Rails.env]['adapter'] == 'sqlite3'
    end
  end
end
