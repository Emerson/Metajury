module ApplicationHelper


  # Outputs bootstrap compatible errors
  def bootstrap_errors(*params)
    options = params.extract_options!.symbolize_keys

    objects = Array.wrap(options.delete(:object) || params).map do |object|
     object = instance_variable_get("@#{object}") unless object.respond_to?(:to_model)
     object = convert_to_model(object)

     if object.class.respond_to?(:model_name)
       options[:object_name] ||= object.class.model_name.human.downcase
     end

     object
    end

    objects.compact!
    count = objects.inject(0) {|sum, object| sum + object.errors.count }

    unless count.zero?
     html = {}
     [:id, :class].each do |key|
       if options.include?(key)
         value = options[key]
         html[key] = value unless value.blank?
       else
         html[key] = 'error_explanation'
       end
     end
     html[:class] << ' alert-error alert block-message'

     options[:object_name] ||= params.first

     I18n.with_options :locale => options[:locale], :scope => [:activerecord, :errors, :template] do |locale|
       header_message = if options.include?(:header_message)
         options[:header_message]
       else
         locale.t :header, :count => count, :model => options[:object_name].to_s.gsub('_', ' ')
       end

       message = options.include?(:message) ? options[:message] : locale.t(:body)

       error_messages = objects.sum do |object|
         object.errors.full_messages.map do |msg|
           content_tag(:li, msg)
         end
       end.join.html_safe

       contents = ''

       unless options.include?(:close) && options[:close] === false
         contents << content_tag(:a, 'x', {:href => "#", :class => 'close'})
       end
       contents << content_tag(options[:header_tag] || :p, content_tag(:strong, header_message)) unless header_message.blank?
       contents << content_tag(:p, message) unless message.blank?
       contents << content_tag(:ul, error_messages)

       if options.include?(:actions)
         buttons = ''
         options[:actions].each do |action|
           buttons << " "+action
         end
         contents << content_tag(:div, buttons.html_safe, {:class => 'alert-actions'})
       end

       content_tag(:div, contents.html_safe, html)
     end
    else
     ''
    end
    end


  def error_class_for(object, property)
    if object.errors.include?(property)
      "error"
    end
  end

  def error_message_for(object, property)
    if object.errors.include?(property)
      "<span class='help-inline'>#{property.to_s.humanize} #{object.errors[property].first}</span>".html_safe
    end
  end

  # A quick helper to output bootstrap buttons
  def bootstrap_button(text, *params)
    options = params.extract_options!.symbolize_keys
    if options.include?(:class)
      options[:class] << " btn small"
    end
    options[:class] ||= "btn small"
    options[:href]  ||= "#"
    content_tag(:a, text, options)
  end


  # Outputs the admin navigation.
  def admin_nav
    items = {'Home' => admin_root_path, 'Users' => admin_users_path}
    output_nav(items)
  end


  # Outputs the user navigation, which depends on wheather
  # a user is currently logged in or not.
  def user_nav
    if @current_user
      items = {'Home' => root_path, 'My Account' => account_path}
    else
      if ApplicationSettings.config['user_registration']
      end
      items = {'Home' => root_path, 'Signup' => signup_path}
    end
    output_nav(items)
  end


  # A utility function that actually outputs the list items and links.
  # Might require some refactoring to better account for "active" nav states.
  def output_nav(items)
    html = Array.new
    items.each do |text, path|
      item_path = Rails.application.routes.recognize_path(path)
      current_path = {:action => params[:action], :controller => params[:controller]}
      class_name = text.downcase
      if item_path[:controller] == current_path[:controller] # && item_path[:action] == current_path[:action]
        class_name << " active"
      end
      html << content_tag(:li, link_to(text, path), :class => class_name)
    end
    html.join("\n").html_safe
  end


  def admin_feed_items(number = 10)
    admin_items = Feed.where('admin = ? OR user_id = ?', true, @current_user.id).order('created_at DESC').limit(number)
    html = Array.new
    admin_items.each do |item|
      feed_data = ActiveSupport::JSON.decode(item.data)
      logger.info("FEED TYPE "+item.feed_type)
      feed_message = sprintf(feed_text_for(item.feed_type), feed_data['first_name']) + " - " + content_tag(:span, time_ago_in_words(item.created_at))
      html << content_tag(:p, feed_message.html_safe)
    end
    html.join("\n").html_safe
  end


  def feed_text_for(feed_type)
    case feed_type
      when 'user_login'
        "%s logged in"
      when 'user_logout'
        "%s logged out"
      when 'user_confirmation'
        "%s confirmed their account"
      when 'user_registration'
        "%s registered an account"
      else
        "%s did something"
    end
  end


end
