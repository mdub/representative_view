require 'action_view'

module RepresentativeView

  module ViewHelpers

    def representative_view(format)
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
      mime_type = Mime::Type.lookup_by_extension(format) || begin
        raise ArgumentError, "unrecognised format: #{format.inspect}"
      end
      case mime_type.to_s
      when /xml/
        ::Representative::Nokogiri
      when /json/
        ::Representative::JSON
      else
        raise "Representative cannot generate #{format}"
      end
    end

  end

end

class ActionView::Base

  include RepresentativeView::ViewHelpers

end
