require "test_helper"

class LikeTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @post = posts(:one)
    @comment = comments(:one)
  end

  test "should belong to user" do
    like = Like.new(user: @user, likeable: @post, value: 1)
    assert_equal @user, like.user
  end

  test "should belong to likeable (post)" do
    like = Like.new(user: @user, likeable: @post, value: 1)
    assert_equal @post, like.likeable
  end

  test "should belong to likeable (comment)" do
    like = Like.new(user: @user, likeable: @comment, value: 1)
    assert_equal @comment, like.likeable
  end

  test "should not allow more than one like per user per likeable" do
    like1 = Like.create!(user: @user, likeable: @post, value: 1)
    like2 = Like.new(user: @user, likeable: @post, value: -1)
    assert_raises(ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid) do
      like2.save!
    end
  end
end
