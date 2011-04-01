require 'representative_view/view_helpers'

module RepresentativeView

  class ActionPack3Handler < ActionView::Template::Handler

    include ActionView::Template::Handlers::Compilable

    self.default_format = Mime::XML

    def compile(template)
      require 'representative/json'
      require 'representative/nokogiri'

      format = template.formats.first
      format = nil if Mime[format] == default_format

      <<-RUBY
      representative_view(#{format.inspect}) do |r|
        #{template.source}
      end
      RUBY
    end

  end

end

ActionView::Template.register_template_handler(:rep, RepresentativeView::ActionPack3Handler)
