require "test_helper"

class SharedLikesPartialTest < ActionView::TestCase
  include LikesHelper

  setup do
    @user = users(:one)
    @post = posts(:one)
    @comment = comments(:one)
  end

  def set_current_user(user)
    Current.session = user.sessions.create!
  end

  test "renders like buttons for post when not voted" do
    set_current_user(@user)
    html = render(partial: "shared/likes", locals: { likeable: @post })
    assert_includes html, "up"
    assert_includes html, "down"
  end

  test "renders like buttons for comment when not voted" do
    set_current_user(@user)
    html = render(partial: "shared/likes", locals: { likeable: @comment })
    assert_includes html, "up"
    assert_includes html, "down"
  end

  test "renders disabled up button when already upvoted post" do
    set_current_user(@user)
    Like.create!(user: @user, likeable: @post, value: 1)
    html = render(partial: "shared/likes", locals: { likeable: @post })
    assert_includes html, 'button disabled="disabled"' # up disabled
  end

  test "renders disabled down button when already downvoted comment" do
    set_current_user(@user)
    Like.create!(user: @user, likeable: @comment, value: -1)
    html = render(partial: "shared/likes", locals: { likeable: @comment })
    assert_includes html, 'button disabled="disabled"' # down disabled
  end
end
