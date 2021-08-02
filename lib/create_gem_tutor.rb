# frozen_string_literal: true

require_relative "create_gem_tutor/version"
require_relative "create_gem_tutor/routing"

module CreateGemTutor
  class Error < StandardError; end

  class Application
    def call(env)
      # handle favicon.ico not exist
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, {'Content-Type' => 'text/html'}, []]
      end

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
  end

  class Controller
    attr_reader :env

    def initialize(env)
      @env = env
    end
  end
end
