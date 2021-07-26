# frozen_string_literal: true

require_relative "create_gem_tutor/version"

module CreateGemTutor
  class Error < StandardError; end

  class Application
    def call(env)
      [200, {'Content-Type' => 'text/html'},
       [env.to_s]]
    end
  end
end
