require "falcor/version"

require 'falcor/class_attrs'
require 'falcor/define_dsl'
require 'falcor/fabricator'
require 'falcor/factory'

module Falcor
end

def Factory(name, overrides={}, &block)
  Falcor::Fabricator.create(name, overrides, block)
end
