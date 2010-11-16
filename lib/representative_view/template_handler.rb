require 'action_view'

module RepresentativeView

  class TemplateHandler < ActionView::Template::Handler

    include ActionView::Template::Handlers::Compilable

    self.default_format = Mime::XML

    def compile(template)
      require 'representative/json'
      require 'representative/nokogiri'
      <<-RUBY
      desired_output_format = formats.first
      r = (desired_output_format == :xml ? ::Representative::Nokogiri : ::Representative::JSON).new
      #{template.source}
      r.send("to_\#{desired_output_format}")
      RUBY
    end

  end

  ActionView::Template.register_template_handler(:rep, TemplateHandler)

end
