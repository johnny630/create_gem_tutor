# frozen_string_literal: true

require_relative "create_gem_tutor/version"
require_relative "create_gem_tutor/routing"

module CreateGemTutor
  class Error < StandardError; end

  class Application
    def call(env)
      # handle favicon.ico not exist
      return favicon if env['PATH_INFO'] == '/favicon.ico'
      return index if env['PATH_INFO'] == '/'

      begin
        klass, action = get_controller_and_action(env)
        controller = klass.new(env)
        text = controller.send(action)

        [
          200,
          {'Content-Type' => 'text/html'},
          [text]
        ]
      rescue
        # handle page not found
        [404, {'Content-Type' => 'text/html'},
          ['This is a 404 page!!']]
      end
    end

    private

    def index
      begin
        home_klass = Object.const_get('HomeController')
        controller = home_klass.new(env)
        text = controller.send(:index)
        [200, {'Content-Type' => 'text/html'}, [text]]
      rescue NameError
        [200, {'Content-Type' => 'text/html'}, ['This is a index page']]
      end
    end

    def favicon
      return [404, {'Content-Type' => 'text/html'}, []]
    end
  end

  class Controller
    attr_reader :env

    def initialize(env)
      @env = env
    end
  end
end
