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

  def bar_height(count1, count2)
    if count1.zero? && count2.zero?
      ratio = 0
    else
      ratio = count1 / (count1 + count2) * 100 # percentage
      ratio = 80 if ratio > 80
    end
    ratio
  end

  def bar_height_b(a_count, b_count)
    b_height = b_count / (a_count + b_count) * 100 # percentage
    b_height = 80 if b_height > 80
    return b_height
  end


end
