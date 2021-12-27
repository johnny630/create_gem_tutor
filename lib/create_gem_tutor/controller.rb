require "create_gem_tutor/file_model"
require 'erubi'

module CreateGemTutor
  class Controller
    include CreateGemTutor::Model

    attr_reader :env, :content

    def initialize(env)
      @env = env
      # 加上一個 @content
      @content = nil
    end

    # 改為直接 render layout
    def render_layout
      layout = File.read "app/views/layouts/application.html.erb"
      text = eval(Erubi::Engine.new(layout).src)
      response(text)
    end

    # 透過寫在 layout 的 <%= content %> 來讀取內容
    def content
      @content
    end

    def render(view_name)
      filename = File.join('app', 'views', controller_name, "#{view_name}.html.erb")
      puts filename
      template = File.read filename

      # 原本直接 render 畫面，改為丟到 @content
      @content = eval(Erubi::Engine.new(template).src)
    end

    def link_to(name = nil, url = nil)
        "<a href=\"#{ url }\">#{ name }</a>"
    end

    def controller_name
      klass = self.class
      klass = klass.to_s.gsub /Controller$/, ''
      klass.to_underscore
    end

    def request
      @request ||= Rack::Request.new(@env)
    end

    def params
      request.params
    end

    def response(text, status = 200, headers = {})
      raise 'Already responded!' if @response
      @response = Rack::Response.new(text, status, headers)
    end

    def get_response
      @response
    end
  end
end
