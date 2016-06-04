module ApplicationHelper

  def auth_token
    """<input type=\"hidden\" name=\"authenticity_token\" value=\"#{form_authenticity_token}\"/>""".html_safe
  end

  def method_tag(method)
    """<input type=\"hidden\" name=\"_method\" value=\"#{method}\" />""".html_safe
  end

  def submit_button(text)
    """<input type=\"submit\" value=\"#{text}\">""".html_safe
  end

end
