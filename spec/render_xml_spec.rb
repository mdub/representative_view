require 'spec_helper'
require 'action_view'

describe "ActionPack" do
  
  it "can render XML" do
    @base = ActionView::Base.new(template_path, {:books => Books.all})
    @base.render(:file => "books").should == undent(<<-XML)
      <books>
        <title>Sailing for old dogs</title>
        <title>On the horizon</title>
        <title>The Little Blue Book of VHS Programming</title>
      </books>
    XML
  end
  
end
