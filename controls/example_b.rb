#
# Profile:: inspec-resource-error
# Control:: example_b
#
# Copyright:: 2017, Doc Walker, All Rights Reserved.

title 'example b'

describe resource_b do
  its('exit_status') { should eq 0 }
end # describe
