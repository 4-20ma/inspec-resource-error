#
# Profile:: inspec-resource-error
# Control:: example_c
#
# Copyright:: 2017, Doc Walker, All Rights Reserved.

title 'example c'

describe resource_c do
  its('exit_status') { should eq 0 }
end # describe
