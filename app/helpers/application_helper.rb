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
      ratio_i = 0
    else
      ratio_f = count1.to_f / (count1.to_f + count2.to_i) # percentage in float
      ratio_i = (ratio_f * 100.to_f).to_i #transform into percentage in integer
      ratio_i = 80 if ratio_i > 80
    end
    ratio_i
  end

  def bar_cap_height(count1, count2)
    bar_h = bar_height(count1, count2)
    bar_h + 2
  end

end
