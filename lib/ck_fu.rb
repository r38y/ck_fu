module Umlatte
  module CkFu
    def ck_fu(options={})
      separator = options[:separator] || "--"
      do_not_show = options[:if] == false || RAILS_ENV == 'production'
      return "" if do_not_show
      xhtml = Builder::XmlMarkup.new :target => out=(''), :indent => 2 # Because I can.
      xhtml.div :id => 'ck_fu', :class => RAILS_ENV do
        xhtml.text! "Env: #{RAILS_ENV.titlecase}"
        xhtml.text! " #{separator} Current DB: #{ActiveRecord::Base.connection.current_database}" if ActiveRecord::Base.connection.respond_to?(:current_database)
        xhtml.text! " #{separator} Current DB: #{ActiveRecord::Base::configurations[RAILS_ENV]['dbfile']}" if ActiveRecord::Base::configurations[RAILS_ENV]['adapter'] == 'sqlite3'
        xhtml.text! " #{separator} Revision: #{deployed_revision}" unless deployed_revision.blank?
        xhtml.text! " #{separator} Deployed: #{deployed_date}" unless deployed_date.blank?
      end
      return out
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
end
