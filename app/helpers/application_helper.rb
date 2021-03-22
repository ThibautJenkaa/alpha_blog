module ApplicationHelper
  def gravatar_for(user, options = { size: 100 })
    require 'digest/md5'
    email_adress = user.email.downcase
    hash = Digest::MD5.hexdigest(email_adress)
    url = "https://www.gravatar.com/avatar/#{hash}?s=#{options[:size]}"
    image_tag(url, alt: user.username)
  end
end
