# Falcor

![Falcor YEAH](http://epicyearproject.files.wordpress.com/2011/05/bastian-falcor-whoop-490.gif)

Falcor is intended to solve several problems, namely, to be able to quickly define fixture data and use it for things like example JSON web services, mocking out tests, and seeding test data into document stores. The DSL should be very familiar to users of tools like FactoryGirl, but it doesn't require the class to exist before you define the factory.

### TODO:

* Traits
* Port over tests
* Examples of usage for README

## Installation

Add this line to your application's Gemfile:

    gem 'falcor'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install falcor

## Usage

Here's how you'd define some factories, create an instance of the new `user` factory, and then turn it into JSON:

```ruby
Falcor::Fabricator.define :blog_post do
  field :title, "My post"
  field :body, "Lots of text"
end

Falcor::Fabricator.define :user do
  field :email, "user@example.com"
  field :full_name, "Matt Gauger"

  create_list :blog_posts, 2, Factory(:blog_post)
end

user = Factory :user

user.to_json
#=> {:email=>"user@example.com",
 :full_name=>"Matt Gauger",
 :blog_posts=>
  [{:title=>"My post", :body=>"Lots of text"},
   {:title=>"My post", :body=>"Lots of text"}]}
```

You can also override defaults:

```ruby
post = Factory :blog_post, title: "My really cool post"

post.title
#=> "My really cool blog post"
```

And much more! (To be continued...)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
