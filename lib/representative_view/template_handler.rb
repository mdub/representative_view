require 'action_view'

module RepresentativeView

  if defined?(ActionView::Template::Handler)
    base_class = ActionView::Template::Handler
  else
    base_class = ActionView::TemplateHandler
  end

  class TemplateHandler < base_class

    if defined?(ActionView::Template::Handlers::Compilable)
      include ActionView::Template::Handlers::Compilable
    else
      include ActionView::TemplateHandlers::Compilable
    end

    self.default_format = Mime::XML if respond_to?(:default_format=)

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

    def mime_type
      if respond_to? :formats
        format_extension = formats.first
      else
        format_extension = template_format
      end
      Mime::Type.lookup_by_extension(format_extension.to_s) || begin
        raise "unrecognised format #{format_extension.inspect}"
      end
    end
    
    def appropriate_representative_class
      case mime_type.to_s
      when /xml/
        ::Representative::Nokogiri
      when /json/
        ::Representative::JSON
      else
        raise "cannot determine appropriate Representative class for #{mime_type.to_s.inspect}"
      end
    end

    def representative_view
      included = defined?(@_representative)
      @_representative ||= appropriate_representative_class.new
      yield @_representative
      @_representative.to_s unless included
    end
    
  end
  
end

if defined? ActionView::Template and ActionView::Template.respond_to? :register_template_handler
  ActionView::Template.register_template_handler(:rep, RepresentativeView::TemplateHandler)
else
  ActionView::Base.register_template_handler(:rep, RepresentativeView::TemplateHandler)
end

class ActionView::Base
  
  include RepresentativeView::ViewHelpers
  
end
