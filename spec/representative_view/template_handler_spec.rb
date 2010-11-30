require 'spec_helper'

describe "a Representative template" do

  before do
    write_template 'books.rep', <<-RUBY
      r.list_of :books, @books do
        r.element :title
      end
    RUBY
  end
  
  it "can generate XML" do
    render("books", :xml, :books => Books.all).should == undent(<<-XML)
      <?xml version="1.0"?>
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

  it "can generate JSON" do
    render("books", :json, :books => Books.all).should == undent(<<-XML)
      [
        {
          "title": "Sailing for old dogs"
        },
        {
          "title": "On the horizon"
        },
        {
          "title": "The Little Blue Book of VHS Programming"
        }
      ]
    XML
  end

end
