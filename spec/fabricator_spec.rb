require 'spec_helper'

describe Falcor::Fabricator do
  describe '.define' do
    it 'can define basic factories' do
      Falcor::Fabricator.define :xyzzy do
        field :foo, "bar"
        field :baz, "quux"
      end

      expect(Falcor::Fabricator.factories).to have_key(:xyzzy)
    end
  end
end
