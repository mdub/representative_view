require 'representative_view/view_helpers'

module RepresentativeView

  class ActionPack3Handler < ActionView::Template::Handler

    self.default_format = nil

    def self.call(template)
      require 'representative/json'
      require 'representative/nokogiri'
      <<-RUBY
      representative_view(formats.first) do |r|
        #{template.source}
      end
      RUBY
    end

  end

end

ActionView::Template.register_template_handler(:rep, RepresentativeView::ActionPack3Handler)
