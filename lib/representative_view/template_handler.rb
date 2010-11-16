require 'action_view'

module RepresentativeView

  class TemplateHandler < ActionView::Template::Handler

    include ActionView::Template::Handlers::Compilable

    self.default_format = Mime::XML

    def compile(template)
      require 'builder'
      require 'representative/xml'
      "xml = ::Builder::XmlMarkup.new(:indent => 2)\n" +
      "r = ::Representative::Xml.new(xml)\n" +
      "self.output_buffer = xml.target!\n" +
      template.source +
      "\nxml.target!\n"
    end

  end

  ActionView::Template.register_template_handler(:rep, TemplateHandler)

end
