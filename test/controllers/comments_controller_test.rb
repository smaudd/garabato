require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in_as(@user)
    @post = posts(:one)
    @comment = comments(:one)
  end

  test "should create comment" do
    assert_difference("Comment.count") do
      post post_comments_path(@post), params: { comment: { body: "Nuevo comentario", user_id: @user.id } }
    end
    assert_redirected_to post_path(@post)
  end

  test "should edit comment" do
    get edit_post_comment_path(@post, @comment)
    assert_response :success
  end

  test "should update comment" do
    patch post_comment_path(@post, @comment), params: { comment: { body: "Editado" } }
    assert_redirected_to post_path(@post)
  end

  test "should destroy comment" do
    assert_difference("Comment.count", -1) do
      delete post_comment_path(@post, @comment)
    end
    assert_redirected_to post_path(@post)
  end
end
