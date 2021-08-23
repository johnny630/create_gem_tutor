module CreateGemTutor
  class Controller
    attr_reader :env, :called_render

    def initialize(env)
      @env = env
      # default set false
      @called_render = false

      # 加上一個 @content
      @content = nil
    end

    # 改為直接 render layout
    def render_layout
      layout = File.read "app/views/layouts/application.html.erb"
      eval(Erubi::Engine.new(layout).src)
    end

    # 透過寫在 layout 的 <%= content %> 來讀取內容
    def content
      @content
    end

    def render(view_name)
      # if execute the render change to true
      @called_render = true
      filename = File.join('app', 'views', controller_name, "#{view_name}.html.erb")
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
      CreateGemTutor.to_underscore(klass)
    end
  end
end
