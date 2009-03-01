require File.dirname(__FILE__) + '/../spec_helper'
include Umlatte

describe Umlatte do
  it "should return a div with an id of ck_fu and class of RAILS_ENV" do
    ck_fu.should == '<div class="test" id="ck_fu">Env: Test &sect; Current DB: </div>'
  end
  
  it "should show a list of links if specified" do
    ck_fu(:links => [['Google', 'http://google.com']]).should == '<div class="test" id="ck_fu">Env: Test &sect; Current DB:  &sect; <a href="http://google.com">Google</a></div>'
  end
  
  it "should be able to specify the separator" do
    ck_fu(:separator => '|').should == '<div class="test" id="ck_fu">Env: Test | Current DB: </div>'
  end
  
  it "should show the deployed date if present" do
    self.stub!(:deployed_date).and_return('today')
    ck_fu.should == '<div class="test" id="ck_fu">Env: Test &sect; Current DB:  &sect; Deployed: today</div>'
  end
  
  it "should not show the deployed date if present but set to false" do
    self.stub!(:deployed_date).and_return('today')
    ck_fu(:date => false).should == '<div class="test" id="ck_fu">Env: Test &sect; Current DB: </div>'
  end
  
  it "should show the deployed revision if present" do
    self.stub!(:deployed_revision).and_return('123')
    ck_fu.should == '<div class="test" id="ck_fu">Env: Test &sect; Current DB:  &sect; Revision: 123</div>'
  end
  
  it "should not show the deployed revision if present but set to false" do
    self.stub!(:deployed_revision).and_return('123')
    ck_fu(:revision => false).should == '<div class="test" id="ck_fu">Env: Test &sect; Current DB: </div>'
  end
  
  it "should not show if :if is not specified and in production environment" do
    Rails.stub!(:production?).and_return(true)
    ck_fu.should == ''
  end
    
  it "should show if :if is true and in production environment" do
    Rails.stub!(:production?).and_return(true)
    ck_fu(:if => true).should == '<div class="test" id="ck_fu">Env: Test &sect; Current DB: </div>'
  end
  
  it "should not show if :if is false and not in production" do
    Rails.stub!(:production?).and_return(false)
    ck_fu(:if => false).should == ''
  end
  
  it "should not show if :if is nil and not in production" do
    Rails.stub!(:production?).and_return(false)
    ck_fu(:if => nil).should == ''
  end
  
  it "should have the current sqlite3 database" do
    ActiveRecord::Base::configurations[RAILS_ENV]['adapter'] = 'sqlite3'
    ActiveRecord::Base::configurations[RAILS_ENV]['dbfile'] = 'test.sqlite3'
    ck_fu.should == '<div class="test" id="ck_fu">Env: Test &sect; Current DB: test.sqlite3</div>'
  end
  
  it "should have the current non-sqlite3 db" do
    ActiveRecord::Base.connection.stub!(:current_database).and_return('something_test')
    ActiveRecord::Base::configurations[RAILS_ENV]['adapter'] = 'mysql'
    ck_fu.should == '<div class="test" id="ck_fu">Env: Test &sect; Current DB: something_test</div>'
  end
end