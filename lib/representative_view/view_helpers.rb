require 'action_view'
require 'representative/json'
require 'representative/nokogiri'

module RepresentativeView

  module ViewHelpers

    def representative_view(format)
      if current_representative
        yield current_representative
      else
        representative(format) do
          yield current_representative
        end
      end
    end

    def representative(format, &block)
      r = create_representative(format)
      with_representative(r, &block)
      r.to_s
    end

    private

    def current_representative
      @_current_representative
    end

    def with_representative(representative)
      old_representative = @_current_representative
      begin
        @_current_representative = representative
        yield representative
      ensure
        @_current_representative = old_representative
      end
    end

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
