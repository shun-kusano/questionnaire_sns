module ApplicationHelper

  def profile_img(user)
    return image_tag(user.avatar, alt: user.name) if user.avatar?

    unless user.provider.blank?
      img_url = user.image_url
    else
      img_url = 'no_image.png'
    end
    image_tag(img_url, alt: user.name)
  end

  def profile_img_url(user)
    if user.provider.present?
      img_url = user.image_url
    elsif user.avatar.blank?
      img_url = 'no_user_avatar.jpg'
    else
      img_url = user.avatar
    end
    return img_url
  end

end
