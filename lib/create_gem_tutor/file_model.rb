require 'multi_json'

module CreateGemTutor
  module Model
    class FileModel
      def initialize(file)
        @file = file
        basename = File.split(file)[-1]
        @id = File.basename(basename, '.json').to_i

        puts "#{file}, #{basename}"
        obj = File.read(file)
        @hash = MultiJson.load(obj)
      end

      def [](name)
        @hash[name.to_s]
      end

      def []=(name, value)
        @hash[name.to_s] = value
      end

      def self.find(id)
        begin
          FileModel.new("db/tasks/#{id}.json")
        rescue
          puts "model not found id: #{id} #{Dir.pwd}"
          return nil
        end
      end
    end
  end
end
