module Umlatte
  module CkFu
    def ck_fu(options={})
      return "" if RAILS_ENV == 'production'
      xhtml = Builder::XmlMarkup.new :target => out=(''), :indent => 2 # Because I can.
      xhtml.div :id => 'ck_fu', :class => RAILS_ENV do
        xhtml.text! "Env: #{RAILS_ENV.titlecase}"
        xhtml.text! " | Current DB: #{ActiveRecord::Base.connection.current_database}" if ActiveRecord::Base.connection.respond_to?(:current_database)
        xhtml.text! " | Current DB: #{ActiveRecord::Base::configurations[RAILS_ENV]['dbfile']}" if ActiveRecord::Base::configurations[RAILS_ENV]['adapter'] == 'sqlite3'
        xhtml.text! " | Revision: #{deployed_revision}" unless deployed_revision.blank?
      end
      return out
    end
    
    def deployed_revision
      file = RAILS_ROOT + '/REVISION'
      File.exists?(file) ? File.open(file).read.strip : nil      
    end
  end
end
