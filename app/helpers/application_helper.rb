module ApplicationHelper
    def gravatar_for(user, options = {size: 80})
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        size = options[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.username, class: "circular")
    end
    
    def alert(type, &block)
        content = content_tag(:span, "×", :class => "closebtn", :href => "") + capture(&block)
        concat content_tag(:div,  content, :class => ("alert " + type), :role => "alert")
    end
end