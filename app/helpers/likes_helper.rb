module LikesHelper
  def like_destroy_path(likeable, user_like)
    if likeable.is_a?(Post)
      post_like_path(likeable, user_like)
    elsif likeable.is_a?(Comment)
      post_comment_like_path(likeable.post, likeable, user_like)
    end
  end

  def like_create_path(likeable)
    if likeable.is_a?(Post)
      post_likes_path(likeable)
    elsif likeable.is_a?(Comment)
      post_comment_likes_path(likeable.post, likeable)
    end
  end

  def like_button(label, likeable, value, user_like, current_value)
    if user_like&.value == value
      button_to label, like_destroy_path(likeable, user_like), method: :delete, form: { data: { turbo_stream: true } }, disabled: true
    elsif user_like
      button_to label, like_create_path(likeable), method: :post, params: { like: { value: value } }, form: { data: { turbo_stream: true } }, disabled: false
    else
      button_to label, like_create_path(likeable), method: :post, params: { like: { value: value } }, form: { data: { turbo_stream: true } }
    end
  end
end
