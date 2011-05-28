require 'action_view'

module RepresentativeView

  module ViewHelpers

    def representative_view(format = nil)
      if defined?(@_representative) 
        yield @_representative # included
      else
        @_representative = appropriate_representative_class(format).new
        yield @_representative
        @_representative.to_s
      end
    end

    private 

    def appropriate_representative_class(format)
      format ||= guess_request_format
      case format.to_s
      when /xml/
        ::Representative::Nokogiri
      when /json/
        ::Representative::JSON
      else
        raise "cannot determine appropriate Representative class for #{format.to_s.inspect}"
      end
    end

    def guess_request_format
      format_extension = if respond_to?(:template_format)
        template_format
      else
        formats.first
      end
      Mime::Type.lookup_by_extension(format_extension) || begin
        raise "unrecognised format #{format_extension.inspect}"
      end
    end

  end

end

class ActionView::Base

  include RepresentativeView::ViewHelpers

end
