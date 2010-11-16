require 'action_view'

module RepresentativeView

  class TemplateHandler < ActionView::Template::Handler

    include ActionView::Template::Handlers::Compilable

    self.default_format = Mime::XML

    def compile(template)
      require 'representative/nokogiri'
      <<-RUBY
      r = ::Representative::Nokogiri.new
      #{template.source}
      r.to_xml(:save_with => (Nokogiri::XML::Node::SaveOptions::FORMAT | Nokogiri::XML::Node::SaveOptions::NO_DECLARATION))
      RUBY
    end

  end

  ActionView::Template.register_template_handler(:rep, TemplateHandler)

end
