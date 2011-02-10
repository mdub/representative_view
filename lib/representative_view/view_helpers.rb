require 'action_view'

module RepresentativeView

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

class ActionView::Base
  
  include RepresentativeView::ViewHelpers
  
end
