require 'action_view'

module RepresentativeView

  module ViewHelpers

    def mime_type
      if respond_to?(:template_format)
        format_extension = template_format
      else
        format_extension = formats.first
      end
      Mime::Type.lookup_by_extension(format_extension.to_s) || begin
        raise "unrecognised format #{format_extension.inspect}"
      end
    end

    def appropriate_representative_class(format)
      case (format || mime_type).to_s
      when /xml/
        ::Representative::Nokogiri
      when /json/
        ::Representative::JSON
      else
        raise "cannot determine appropriate Representative class for #{mime_type.to_s.inspect}"
      end
    end

    def representative_view(format = nil)
      included = defined?(@_representative)
      @_representative ||= appropriate_representative_class(format).new
      yield @_representative
      @_representative.to_s unless included
    end

  end

end

class ActionView::Base

  include RepresentativeView::ViewHelpers

end
