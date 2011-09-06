require 'spec_helper'
require 'action_controller'

describe "a Representative template" do

  before do
    write_template 'books.rep', <<-RUBY
      r.list_of :books, @books do
        r.element :title
      end
    RUBY
    RepresentativeView.json_options = {}
    RepresentativeView.xml_options = {}
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

  it "can generate XML dialects" do
    Mime::Type.register "application/vnd.books+xml", :book_xml
    render("books", :book_xml, :books => Books.all).should == undent(<<-XML)
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
    render("books", :json, :books => Books.all).should == undent(<<-JSON)
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
    JSON
  end

  it "can include partials" do

    write_template 'books_with_partial.rep', <<-RUBY
    r.list_of :books, @books do
      render :partial => 'book'
    end
    RUBY

    write_template '_book.rep', <<-RUBY
    r.element :title
    r.element :published do
      r.element :by
    end
    RUBY

    render("books_with_partial", :json, :books => Books.all).should == undent(<<-JSON)
      [
        {
          "title": "Sailing for old dogs",
          "published": {
            "by": "Credulous Print"
          }
        },
        {
          "title": "On the horizon",
          "published": {
            "by": "McGraw-Hill"
          }
        },
        {
          "title": "The Little Blue Book of VHS Programming",
          "published": null
        }
      ]
    JSON

  end

  it "can force a format for partials" do

    write_template '_books.rep', <<-RUBY
      r.list_of :books, @books do
        r.element :title
      end
    RUBY

    write_template 'books.html.erb', undent(<<-HTML)
      <h2>JSON REPRESENTATION</h2>

      <pre>
      <%= h representative(:json) { render :partial => 'books' } %></pre>

      <h2>XML REPRESENTATION</h2>

      <pre>
      <%= h representative(:xml) { render :partial => 'books' } %></pre>
    HTML

    render("books", :html, :books => Books.all).should == undent(<<-HTML)
      <h2>JSON REPRESENTATION</h2>

      <pre>
      [
        {
          &quot;title&quot;: &quot;Sailing for old dogs&quot;
        },
        {
          &quot;title&quot;: &quot;On the horizon&quot;
        },
        {
          &quot;title&quot;: &quot;The Little Blue Book of VHS Programming&quot;
        }
      ]
      </pre>

      <h2>XML REPRESENTATION</h2>

      <pre>
      &lt;?xml version=&quot;1.0&quot;?&gt;
      &lt;books type=&quot;array&quot;&gt;
        &lt;book&gt;
          &lt;title&gt;Sailing for old dogs&lt;/title&gt;
        &lt;/book&gt;
        &lt;book&gt;
          &lt;title&gt;On the horizon&lt;/title&gt;
        &lt;/book&gt;
        &lt;book&gt;
          &lt;title&gt;The Little Blue Book of VHS Programming&lt;/title&gt;
        &lt;/book&gt;
      &lt;/books&gt;
      </pre>
    HTML

  end

  it "allows configuration of json_options" do

    RepresentativeView.json_options = {:naming_strategy => :upcase}

    render("books", :json, :books => Books.all).should == undent(<<-JSON)
      [
        {
          "TITLE": "Sailing for old dogs"
        },
        {
          "TITLE": "On the horizon"
        },
        {
          "TITLE": "The Little Blue Book of VHS Programming"
        }
      ]
    JSON

  end

  it "allows configuration of xml_options" do

    RepresentativeView.xml_options = {:naming_strategy => :upcase}

    render("books", :xml, :books => Books.all).should == undent(<<-XML)
      <?xml version="1.0"?>
      <BOOKS TYPE="array">
        <BOOK>
          <TITLE>Sailing for old dogs</TITLE>
        </BOOK>
        <BOOK>
          <TITLE>On the horizon</TITLE>
        </BOOK>
        <BOOK>
          <TITLE>The Little Blue Book of VHS Programming</TITLE>
        </BOOK>
      </BOOKS>
    XML

  end

end
