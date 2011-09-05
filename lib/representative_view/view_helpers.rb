require 'action_view'

module RepresentativeView

  module ViewHelpers

    def representative_view(format)
      if defined?(@_representative)
        yield @_representative # included
      else
        @_representative = create_representative(format)
        yield @_representative
        @_representative.to_s
      end
    end

    private

    def create_representative(format)
      mime_type = Mime::Type.lookup_by_extension(format) || begin
        raise ArgumentError, "unrecognised format: #{format.inspect}"
      end
      case mime_type.to_s
      when /xml/
        ::Representative::Nokogiri.new(nil, RepresentativeView.xml_options)
      when /json/
        ::Representative::JSON.new(nil, RepresentativeView.json_options)
      else
        raise "Representative cannot generate #{format}"
      end
    end

  end

end

class ActionView::Base

  include RepresentativeView::ViewHelpers

end
