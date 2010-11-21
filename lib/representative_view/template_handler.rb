require 'action_view'

module RepresentativeView

  class TemplateHandler < ActionView::Template::Handler

    include ActionView::Template::Handlers::Compilable

    self.default_format = Mime::XML

    def compile(template)
      require 'representative/json'
      require 'representative/nokogiri'
      <<-RUBY
      representative_view do |r|
        #{template.source}
      end
      RUBY
    end

  end

  module ViewHelpers

    def representative_class_for_format(output_format)
      case output_format
      when :xml
        ::Representative::Nokogiri
      when :json
        ::Representative::JSON
      end
    end

    def representative_view
      output_format = formats.first
      r = representative_class_for_format(output_format).new
      yield r
      r.send("to_#{output_format}")
    end
    
  end
  
end

ActionView::Template.register_template_handler(:rep, RepresentativeView::TemplateHandler)

class ActionView::Base
  
  include RepresentativeView::ViewHelpers
  
end