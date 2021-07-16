# CreateGemTutor

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/create_gem_tutor`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'create_gem_tutor'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install create_gem_tutor

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/create_gem_tutor. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/create_gem_tutor/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CreateGemTutor project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/create_gem_tutor/blob/main/CODE_OF_CONDUCT.md).


Step 1
`gem update bundler`  
`gem install bundler`  

`bundle gem hola_el_mundo` create a gem (with floder)  
When success result will show:  

```
Creating gem 'create_gem_tutor'...
MIT License enabled in config
Code of conduct enabled in config
Changelog enabled in config
RuboCop enabled in config
Initializing git repo in /Users/johnnyliu/Documents/rubyProjects/create_gem_tutor
      create  create_gem_tutor/Gemfile
      create  create_gem_tutor/lib/create_gem_tutor.rb
      create  create_gem_tutor/lib/create_gem_tutor/version.rb
      create  create_gem_tutor/create_gem_tutor.gemspec
      create  create_gem_tutor/Rakefile
      create  create_gem_tutor/README.md
      create  create_gem_tutor/bin/console
      create  create_gem_tutor/bin/setup
    conflict  create_gem_tutor/.gitignore
Overwrite /Users/johnnyliu/Documents/rubyProjects/create_gem_tutor/.gitignore? (enter "h" for help) [Ynaqdhm] h
        Y - yes, overwrite
        n - no, do not overwrite
        a - all, overwrite this and all others
        q - quit, abort
        d - diff, show the differences between the old and the new
        h - help, show this help
        m - merge, run merge tool
Overwrite /Users/johnnyliu/Documents/rubyProjects/create_gem_tutor/.gitignore? (enter "h" for help) [Ynaqdhm] Y
       force  create_gem_tutor/.gitignore
      create  create_gem_tutor/.rspec
      create  create_gem_tutor/spec/spec_helper.rb
      create  create_gem_tutor/spec/create_gem_tutor_spec.rb
      create  create_gem_tutor/.github/workflows/main.yml
      create  create_gem_tutor/LICENSE.txt
      create  create_gem_tutor/CODE_OF_CONDUCT.md
      create  create_gem_tutor/CHANGELOG.md
      create  create_gem_tutor/.rubocop.yml
```