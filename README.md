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

### Defining factories & creating instances

Here's how you'd define some factories, create an instance of the new `user` factory, and then turn it into a hash to use as JSON:

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

=> {"email"=>"user@example.com",
 "full_name"=>"Matt Gauger",
 "blog_posts"=>
  [{"title"=>"My post", "body"=>"Lots of text"},
   {"title"=>"My post", "body"=>"Lots of text"}]}
```

### Overriding defaults

You can also override defaults:

```ruby
post = Factory :blog_post, title: "My really cool post"

post.title
=> "My really cool blog post"
```

### Optional fields

For optional fields on factories (those that don't have a default value and shouldn't show up in JSON unless set), use `allow`:

```ruby
Falcor::Fabricator.define :contact do
  allow :full_name
  allow :phone_number
  allow :address
end

contact = Factory :contact, full_name: "Robert Pitts"

contact.to_json
=> {"full_name"=>"Robert Pitts"} # Other attributes don't appear in JSON
```

### Associations

The most basic form of association assumes that the name of the attribute matches the Factory of the assocation:

```ruby
Falcor::Fabricator.define :metadata do
  field :api_version, "2.1"
  field :stub_data, false
end

Falcor::Fabricator.define :report do
  field :name, "Simple Report"
  field :answer, 42
  association :metadata
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
