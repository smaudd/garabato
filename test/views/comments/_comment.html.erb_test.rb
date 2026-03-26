require "test_helper"

class CommentsPartialTest < ActionView::TestCase
  include LikesHelper

  setup do
    @user = users(:one)
    @post = posts(:one)
    @comment = comments(:one)
    Current.session = @user.sessions.create!
  end

  test "renders comment body and author" do
    html = render(partial: "comments/comment", locals: { comment: @comment })
    assert_includes html, @comment.body
    assert_includes html, @comment.user&.email_address
  end

  test "renders like buttons for comment" do
    html = render(partial: "comments/comment", locals: { comment: @comment })
    assert_includes html, "up"
    assert_includes html, "down"
  end
end
