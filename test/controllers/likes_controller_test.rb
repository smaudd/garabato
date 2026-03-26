require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @post = posts(:one)
    @comment = comments(:one)
    sign_in_as(@user)
  end

  test "should create like for post" do
    assert_difference("Like.count") do
      post post_likes_path(@post), params: { like: { value: 1 } }
    end
    assert_redirected_to root_path
  end

  test "should destroy like for post" do
    like = Like.create!(user: @user, likeable: @post, value: 1)
    assert_difference("Like.count", -1) do
      delete post_like_path(@post, like)
    end
    assert_redirected_to root_path
  end

  test "should create like for comment" do
    assert_difference("Like.count") do
      post post_comment_likes_path(@post, @comment), params: { like: { value: 1 } }
    end
    assert_redirected_to root_path
  end

  test "should destroy like for comment" do
    like = Like.create!(user: @user, likeable: @comment, value: 1)
    assert_difference("Like.count", -1) do
      delete post_comment_like_path(@post, @comment, like)
    end
    assert_redirected_to root_path
  end
end
