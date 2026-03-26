require "test_helper"

class PostsPartialTest < ActionView::TestCase
  include LikesHelper

  setup do
    @user = users(:one)
    @post = posts(:one)
    Current.session = @user.sessions.create!
  end

  test "renders post title" do
    html = render(partial: "posts/post", locals: { post: @post })
    assert_includes html, @post.title
  end

  test "renders like buttons for post" do
    html = render(partial: "posts/post", locals: { post: @post })
    assert_includes html, "up"
    assert_includes html, "down"
  end
end
