require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in_as(@user)
    @post = posts(:one)
  end

  test "should not create comment with empty body" do
    assert_no_difference("Comment.count") do
      post post_comments_path(@post), params: { comment: { body: "" } }
    end
    assert_response :unprocessable_entity
  end

  test "should show errors when comment body is empty" do
    post post_comments_path(@post), params: { comment: { body: "" } }
    assert_response :unprocessable_entity
    assert_select "div", /prohibited this comment from being saved/
    assert_select "li", /Body can't be blank/
  end
end
