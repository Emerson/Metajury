module CommentsHelper

  def nested_comments(comments)
    comments.map do |comment, child_comments|
      render(comment) + content_tag(:div, nested_comments(child_comments), :class => 'nested_comments')
    end.join.html_safe
  end

end
