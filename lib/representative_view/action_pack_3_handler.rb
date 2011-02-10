require 'representative_view/view_helpers'

module RepresentativeView

  class ActionPack3Handler < ActionView::Template::Handler

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

end

ActionView::Template.register_template_handler(:rep, RepresentativeView::ActionPack3Handler)
