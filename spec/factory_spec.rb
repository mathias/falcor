require 'spec_helper'

describe 'Factory' do
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
end
