# frozen_string_literal: true

require_relative "create_gem_tutor/version"
require_relative "create_gem_tutor/routing"

module CreateGemTutor
  class Error < StandardError; end

  class Application
    def call(env)
      klass, action = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(action)

      [
        200,
        {'Content-Type' => 'text/html'},
        [text]
      ]
    end
  end

  class Controller
    attr_reader :env

    def initialize(env)
      @env = env
    end
  end
end
