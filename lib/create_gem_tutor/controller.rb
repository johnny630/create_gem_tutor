module CreateGemTutor
  class Controller
    attr_reader :env

    def initialize(env)
        @env = env
    end

    def render(view_name)
      filename = File.join('app', 'views', controller_name, "#{view_name}.html.erb")
      template = File.read filename
      eval(Erubi::Engine.new(template).src)
    end

    def controller_name
      klass = self.class
      klass = klass.to_s.gsub /Controller$/, ''
      CreateGemTutor.to_underscore(klass)
    end
  end
end
