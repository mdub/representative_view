require 'representative_view/view_helpers'

module RepresentativeView

  class ActionPack4Handler

    def self.call(template)
      <<-RUBY
      representative_view(formats.first) do |r|
        #{template.source}
      end
      RUBY
    end

  end

end

ActionView::Template.register_template_handler(:rep, RepresentativeView::ActionPack4Handler)
