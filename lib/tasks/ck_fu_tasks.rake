namespace :ck_fu do
  desc "Copy default stylesheet to public/stylesheets"
  task :copy_styles do
    FileUtils.cp File.join(File.dirname(__FILE__), '../public/stylesheets/ck_fu.css'),  File.join(RAILS_ROOT, 'public', 'stylesheets')
  end
  
  desc "Delete default stylesheet from public/stylesheets"
  task :delete_styles do
    FileUtils.rm File.join(RAILS_ROOT, 'public', 'stylesheets', 'ck_fu.css') rescue nil
  end
end
