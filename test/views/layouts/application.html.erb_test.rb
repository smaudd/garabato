require "test_helper"

class ApplicationLayoutTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in_as(@user)
    @post = posts(:one)
  end

  test "flash notice is rendered with correct class after create post" do
    assert_difference("Post.count") do
      post posts_path, params: { post: { title: "Test Post" } }
    end
    follow_redirect!
    assert_select "p.notice", text: "Post was successfully created."
  end

  test "flash alert is rendered with correct class after failed session" do
    post session_path, params: { email_address: @user.email_address, password: "wrong" }
    follow_redirect!
    assert_select "p.alert", text: "Try another email address or password."
  end
end
