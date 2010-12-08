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

    def mime_type
      format_extension = formats.first
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

ActionView::Template.register_template_handler(:rep, RepresentativeView::TemplateHandler)

class ActionView::Base
  
  include RepresentativeView::ViewHelpers
  
end