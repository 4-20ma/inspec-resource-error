#
# Profile:: inspec-resource-error
# Control:: example_a
#
# Copyright:: 2017, Doc Walker, All Rights Reserved.

title 'example a'

describe resource_a do
  its('exit_status') { should eq 0 }
end # describe
