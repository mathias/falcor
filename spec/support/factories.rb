module Support
  module Factories

    def factories
      Falcor::Fabricator.define :author do
        field :username, "matt@example.com"
        field :password, "password"
      end

      Falcor::Fabricator.define :blog_post do
        field :title, "My post"
        field :body, "Lots of text"
        association :author
      end
    end

  end
end

RSpec.configuration.include Support::Factories
