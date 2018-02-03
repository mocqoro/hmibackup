module ApplicationHelper
    def gravatar_for(user, options = {size: 80, animated: false})
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        size = options[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        img_class = "circular"
        img_class += "-animated" if options[:animated]
        image_tag(gravatar_url, alt: user.username, class: img_class)
    end
    
    def alert(type, &block)
        content = content_tag(:span, "×", :class => "closebtn", :href => "") + capture(&block)
        concat content_tag(:div,  content, :class => ("alert " + type), :role => "alert")
    end
end