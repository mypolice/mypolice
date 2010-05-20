require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end

  test "should require title" do
    p = Post.create(:title=>nil)
    assert p.errors[:title]
  end

  test "should require body" do
    p = Post.create(:body=>nil)
    assert p.errors[:body]
  end

  test "should be created" do
    p = Post.create(
    :title =>'I am a test title',
    :body =>'I am a test body')
    assert p.valid?
  end
end
