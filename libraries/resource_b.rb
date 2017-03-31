#
# Profile:: inspec-resource-error
# Resource:: resource_b
#
# Copyright:: 2017, Doc Walker, All Rights Reserved.

class ResourceB < Inspec.resource(1)
  name 'resource_b'

  desc '
    Inspec.resource class inheritance example
  '

  example "
  "

  def initialize
    @cmd = 'true'
  end # initialize

  def result
    @result ||= inspec.backend.run_command(@cmd)
  end # result

  def stdout
    result.stdout.chomp
  end # stdout

  def stderr
    result.stderr.chomp
  end # stderr

  def exit_status
    result.exit_status.to_i
  end # exit_status

  def to_s
    "ResourceB #{@cmd}"
  end # to_s
end # class
