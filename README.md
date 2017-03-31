# inspec-resource-error

This example reproduces an error with resource class inheritance.

Refer to [chef/inspec issue #1613](https://github.com/chef/inspec/issues/1613).


## Versions

ruby

    $ ruby --version
    ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-darwin16]

inspec gem

    $ inspec version
    WARN: Unresolved specs during Gem::Specification.reset:
          nokogiri (~> 1.6)
    WARN: Clearing out unresolved specs.
    Please report a bug if this causes problems.
    1.18.0

chefdk

    $ chef --version
    Chef Development Kit Version: 1.2.22
    chef-client version: 12.18.31
    delivery version: master (0b746cafed65a9ea1a79de3cc546e7922de9187c)
    berks version: 5.6.2
    kitchen version: 1.15.0

chefdk-1.2.22 has inspec gem pinned at 1.11.0

    $ chef exec inspec version
    1.11.0

    Your version of InSpec is out of date! The latest version is 1.18.0.


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

Using inspec-1.18.0 gem

    $ inspec check .
    WARN: Unresolved specs during Gem::Specification.reset:
          nokogiri (~> 1.6)
    WARN: Clearing out unresolved specs.
    Please report a bug if this causes problems.
    Location:    .
    Profile:     inspec-resource-error
    Controls:    3
    Timestamp:   2017-03-30T21:13:03-05:00
    Valid:       true

    No errors or warnings

Using chefdk inspec-1.11.0 gem

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

Using inspec-1.18.0 gem

    $ inspec check .
    WARN: Unresolved specs during Gem::Specification.reset:
          nokogiri (~> 1.6)
    WARN: Clearing out unresolved specs.
    Please report a bug if this causes problems.
    libraries/resource_a.rb:14:in `load_with_context': uninitialized constant #<Class:#<#<Class:0x007f82167d6910>:0x007f82167d6758>>::ResourceB (NameError)
    	from /Users/me/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/inspec-1.18.0/lib/inspec/profile_context.rb:146:in `instance_eval'
    	from /Users/me/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/inspec-1.18.0/lib/inspec/profile_context.rb:146:in `load_with_context'
    	from /Users/me/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/inspec-1.18.0/lib/inspec/profile_context.rb:135:in `load_library_file'
    	from /Users/me/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/inspec-1.18.0/lib/inspec/profile_context.rb:124:in `block in load_libraries'
    	from /Users/me/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/inspec-1.18.0/lib/inspec/profile_context.rb:122:in `each'
    	from /Users/me/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/inspec-1.18.0/lib/inspec/profile_context.rb:122:in `load_libraries'
    	from /Users/me/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/inspec-1.18.0/lib/inspec/profile.rb:171:in `load_libraries'
    	from /Users/me/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/inspec-1.18.0/lib/inspec/profile.rb:425:in `load_checks_params'
    	from /Users/me/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/inspec-1.18.0/lib/inspec/profile.rb:419:in `load_params'
    	from /Users/me/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/inspec-1.18.0/lib/inspec/profile.rb:134:in `params'
    	from /Users/me/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/inspec-1.18.0/lib/inspec/profile.rb:299:in `controls_count'
    	from /Users/me/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/inspec-1.18.0/lib/inspec/profile.rb:270:in `check'
    	from /Users/me/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/inspec-1.18.0/lib/inspec/cli.rb:69:in `check'
    	from /Users/me/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/thor-0.19.1/lib/thor/command.rb:27:in `run'
    	from /Users/me/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/thor-0.19.1/lib/thor/invocation.rb:126:in `invoke_command'
    	from /Users/me/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/thor-0.19.1/lib/thor.rb:359:in `dispatch'
    	from /Users/me/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/thor-0.19.1/lib/thor/base.rb:440:in `start'
    	from /Users/me/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/inspec-1.18.0/bin/inspec:12:in `<top (required)>'
    	from /Users/me/.rbenv/versions/2.3.1/bin/inspec:23:in `load'
    	from /Users/me/.rbenv/versions/2.3.1/bin/inspec:23:in `<main>'

Using chefdk inspec-1.11.0 gem

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


## Works

Rename `resource_b.rb` to `_resource_b.rb`

`libraries/_resource_b.rb`

    class ResourceB < Inspec.resource(1)
      name 'resource_b'
      ...
    end # class

`libraries/resource_a.rb`

    class ResourceA < ResourceB
      name 'resource_a'
      ...
    end # class

Using inspec-1.18.0 gem

    $ inspec check .
    WARN: Unresolved specs during Gem::Specification.reset:
          nokogiri (~> 1.6)
    WARN: Clearing out unresolved specs.
    Please report a bug if this causes problems.
    Location:    .
    Profile:     inspec-resource-error
    Controls:    3
    Timestamp:   2017-03-30T21:29:07-05:00
    Valid:       true

    No errors or warnings

Using chefdk inspec-1.11.0 gem

    $ chef exec inspec check .
    Location:    .
    Profile:     inspec-resource-error
    Controls:    3
    Timestamp:   2017-03-30T21:30:09-05:00
    Valid:       true

    No errors or warnings
