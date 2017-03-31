#
# Profile:: inspec-resource-error
# Resource:: resource_a
#
# Copyright:: 2017, Doc Walker, All Rights Reserved.

# doesn't resolve load error
# require 'resource_b'

# works
# class ResourceA < Inspec.resource(1)

# does not work
class ResourceA < ResourceB
  name 'resource_a'

  desc '
    Inspec.resource class inheritance example
  '

  example "
    class ResourceA < Inspec.resource(1)    -- works
    class ResourceA < ResourceB             -- does not work
  "

  def initialize
    super
  end # initialize

  def to_s
    "ResourceA"
  end # to_s
end # class
