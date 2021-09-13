require 'sqlite3'
require 'create_gem_tutor/support'

DB = SQLite3::Database.new 'just_do.db'

module CreateGemTutor
  module Model
    class SQLite
      def self.table
        table_name = CreateGemTutor.to_underscore name
        CreateGemTutor.to_plural table_name
      end

      def self.schema
        return @schema if @schema
        @schema = {}

        DB.table_info(table) do |row|
          @schema[row['name']] = row['type']
        end
        @schema
      end
    end
  end
end
