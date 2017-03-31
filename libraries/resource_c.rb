#
# Profile:: inspec-resource-error
# Resource:: resource_c
#
# Copyright:: 2017, Doc Walker, All Rights Reserved.

class ResourceC < ResourceB
  name 'resource_c'

  desc '
    Inspec.resource class inheritance example
  '

  example "
  "

  def initialize
    super
  end # initialize

  def to_s
    "ResourceC"
  end # to_s
end # class
