# frozen_string_literal: true

require "create_gem_tutor/version"
require "create_gem_tutor/routing"
require "create_gem_tutor/controller"
require 'active_support'
require 'active_record'

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
        controller.send(action)
        puts controller
        puts action
        # if won't call controller render, then execute default render
        default_render(controller, action) unless controller.content
        controller.render_layout

        if controller.get_response
          controller.get_response.to_a
        else
          [
            500,
            {'Content-Type' => 'text/html'},
            ['server error!!']
          ]
        end
      rescue => e
        puts e
        puts e.backtrace
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

    def default_render(controller, action)
      controller.render(action)
    end
  end
end
