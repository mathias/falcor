require 'spec_helper'

describe 'Factory' do
  context 'basic factory functionality' do
    before do
      Falcor::Fabricator.define :blog_post do
        field :title, "My post"
        field :body, "Lots of text"
      end
    end

    it 'can create a basic factory with default attributes' do
      post = Factory :blog_post
      expect(post.title).to eq "My post"
      expect(post.body).to eq "Lots of text"
    end

    it 'generates the expected hash for JSON' do
      post = Factory :blog_post
      expect(post.to_json).to eq({ "title" => "My post", "body" => "Lots of text" })
    end

    it 'allows attributes to be overridden' do
      post = Factory :blog_post, title: "My super sweet post"
      expect(post.title).to eq "My super sweet post"
    end
  end

  context 'factory associations' do
    before { factories }

    it 'can create associations that default to the factory named by the attribute' do
      post = Factory :blog_post
      expect(post.author.username).to eq "matt@example.com"
    end

    it 'generates the expected hash for JSON' do
      blog_post = Factory :blog_post
      blog_post_hash = blog_post.to_json

      expect(blog_post_hash).to be_a(Hash)
      expect(blog_post_hash).to have_key('author')
      expect(blog_post_hash).to have_key('title')
      expect(blog_post_hash).to have_key('body')
      expect(blog_post_hash).to eq(
      {
        "title"=>"My post",
        "body"=>"Lots of text",
        "author"=>{
          "username"=>"matt@example.com",
          "password"=>"password"
        }
      })
    end
  end

  def factories
    Falcor::Fabricator.define :author do
      field :username, "matt@example.com"
      field :password, "password"
    end

    Falcor::Fabricator.define :blog_post do
      field :title, "My post"
      field :body, "Lots of text"
      association :author
    end
  end

end
