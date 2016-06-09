require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'
require 'byebug'
require_relative './session'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, route_params)
    @req = req
    @res = res
    @params = @req.params.merge(route_params)
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response ||= false
  end

  # Set the response status code and header
  def redirect_to(url)
    if @already_built_response
      raise "Can't redirect twice"
    else
      @already_built_response = true
    end

    @res.header["location"] = url
    @res.status = 302

    session.store_session(@res)
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    if @already_built_response
      raise "Can't render twice"
    else
      @already_built_response = true
    end

    @res['Content-Type'] = content_type
    @res.write(content)

    session.store_session(@res)
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    byebug
    path = "views/#{self.class.name.underscore}/#{template_name}.html.erb"
    erb_template = ERB.new(File.read(path))
    evaluated_template = erb_template.result(binding)

    render_content(evaluated_template, "text/html")
    session.store_session(@res)
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    self.send(name)
    unless @already_build_reponse
      render(name.to_s)
    end
  end
end
