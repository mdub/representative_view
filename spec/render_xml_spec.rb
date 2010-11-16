require 'spec_helper'

describe "rendering" do

  before do
    @base = ActionView::Base.new(template_path, {:books => Books.all})
  end
  
  describe "a Builder template" do
    it "generates XML" do
      @base.render(:file => "books-b").should == undent(<<-XML)
        <books type="array">
          <book>
            <title>Sailing for old dogs</title>
          </book>
          <book>
            <title>On the horizon</title>
          </book>
          <book>
            <title>The Little Blue Book of VHS Programming</title>
          </book>
        </books>
      XML
    end
  end

  describe "a Representative template" do
    it "generates XML" do
      @base.render(:file => "books-r").should == undent(<<-XML)
        <books type="array">
          <book>
            <title>Sailing for old dogs</title>
          </book>
          <book>
            <title>On the horizon</title>
          </book>
          <book>
            <title>The Little Blue Book of VHS Programming</title>
          </book>
        </books>
      XML
    end
  end
  
end
