require 'spec_helper'
require 'action_view'

describe "fixtures" do

  it "contains books" do
    Books.all.should be_kind_of(Array)
  end

end

TEMPLATE_PATH = File.join(File.dirname(__FILE__), "fixtures", "templates")

describe "ActionPack" do
  
  it "can render XML" do
    @base = ActionView::Base.new(TEMPLATE_PATH, {})
    @base.render(:inline => "<%= 100 + 23 %>", :type => :erb).should == "123"
  end
  
end
