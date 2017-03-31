# inspec-resource-error

This example reproduces an error with resource class inheritance.


## Versions

    $ chef --version
    Chef Development Kit Version: 1.2.22
    chef-client version: 12.18.31
    delivery version: master (0b746cafed65a9ea1a79de3cc546e7922de9187c)
    berks version: 5.6.2
    kitchen version: 1.15.0


Notes

  - chefdk-1.2.22 has inspec gem pinned at 1.11.0
  - inspec-1.18.0 also exhibits the same error


## Setup

Create profile

    $ chef exec inspec init profile inspec-resource-error

Create simple resources with the following class inheritance

  - resource_a.rb:  ResourceA < ResourceB
  - resource_b.rb:  ResourceB < Inspec.resource(1)
  - resource_c.rb:  ResourceC < ResourceB

Create controls to test resources

  - example_a.rb
  - example_b.rb
  - example_c.rb


## Works

`libraries/resource_a.rb`

    class ResourceA < Inspec.resource(1)
      name 'resource_a'
      ...
    end # class

    $ chef exec inspec check .
    Location:    .
    Profile:     inspec-resource-error
    Controls:    3
    Timestamp:   2017-03-30T20:46:01-05:00
    Valid:       true

    No errors or warnings


## Doesn't work

`libraries/resource_a.rb`

    class ResourceA < ResourceB
      name 'resource_a'
      ...
    end # class

    $ chef exec inspec check .
    libraries/resource_a.rb:11:in `load_with_context': uninitialized constant #<Class:#<#<Class:0x007fbe8c0f5260>:0x007fbe8c0f5170>>::ResourceB (NameError)
    	from /opt/chefdk/embedded/lib/ruby/gems/2.3.0/gems/inspec-1.11.0/lib/inspec/profile_context.rb:146:in `instance_eval'
    	from /opt/chefdk/embedded/lib/ruby/gems/2.3.0/gems/inspec-1.11.0/lib/inspec/profile_context.rb:146:in `load_with_context'
    	from /opt/chefdk/embedded/lib/ruby/gems/2.3.0/gems/inspec-1.11.0/lib/inspec/profile_context.rb:135:in `load_library_file'
    	from /opt/chefdk/embedded/lib/ruby/gems/2.3.0/gems/inspec-1.11.0/lib/inspec/profile_context.rb:124:in `block in load_libraries'
    	from /opt/chefdk/embedded/lib/ruby/gems/2.3.0/gems/inspec-1.11.0/lib/inspec/profile_context.rb:122:in `each'
    	from /opt/chefdk/embedded/lib/ruby/gems/2.3.0/gems/inspec-1.11.0/lib/inspec/profile_context.rb:122:in `load_libraries'
    	from /opt/chefdk/embedded/lib/ruby/gems/2.3.0/gems/inspec-1.11.0/lib/inspec/profile.rb:171:in `load_libraries'
    	from /opt/chefdk/embedded/lib/ruby/gems/2.3.0/gems/inspec-1.11.0/lib/inspec/profile.rb:419:in `load_checks_params'
    	from /opt/chefdk/embedded/lib/ruby/gems/2.3.0/gems/inspec-1.11.0/lib/inspec/profile.rb:413:in `load_params'
    	from /opt/chefdk/embedded/lib/ruby/gems/2.3.0/gems/inspec-1.11.0/lib/inspec/profile.rb:134:in `params'
    	from /opt/chefdk/embedded/lib/ruby/gems/2.3.0/gems/inspec-1.11.0/lib/inspec/profile.rb:299:in `controls_count'
    	from /opt/chefdk/embedded/lib/ruby/gems/2.3.0/gems/inspec-1.11.0/lib/inspec/profile.rb:270:in `check'
    	from /opt/chefdk/embedded/lib/ruby/gems/2.3.0/gems/inspec-1.11.0/lib/inspec/cli.rb:68:in `check'
    	from /opt/chefdk/embedded/lib/ruby/gems/2.3.0/gems/thor-0.19.1/lib/thor/command.rb:27:in `run'
    	from /opt/chefdk/embedded/lib/ruby/gems/2.3.0/gems/thor-0.19.1/lib/thor/invocation.rb:126:in `invoke_command'
    	from /opt/chefdk/embedded/lib/ruby/gems/2.3.0/gems/thor-0.19.1/lib/thor.rb:359:in `dispatch'
    	from /opt/chefdk/embedded/lib/ruby/gems/2.3.0/gems/thor-0.19.1/lib/thor/base.rb:440:in `start'
    	from /opt/chefdk/embedded/lib/ruby/gems/2.3.0/gems/inspec-1.11.0/bin/inspec:12:in `<top (required)>'
    	from /opt/chefdk/bin/inspec:59:in `load'
    	from /opt/chefdk/bin/inspec:59:in `<main>'    
