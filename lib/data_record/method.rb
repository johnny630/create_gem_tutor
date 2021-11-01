require 'yaml'

module CreateGemTutor
  module DataRecord
    module Method
      def establish_connection
        raw = File.read('config/database.yml')
        database_config = YAML.safe_load(raw)

        case database_config['default']['adapter']
        when 'postgresql'
          @@connection = ConnectionAdapter::PostgreSQLAdapter.new(
            database_config['development']['host'] || '127.0.0.1',
            database_config['development']['user'] || 'postgres',
            database_config['development']['database'],
            database_config['development']['password'] || 'Passw0rd'
          )
        when 'sqlite'
            # sqlite connection
        end
      end

      def connection
        @@connection
      end

      def schema
        self.connection.exec("SELECT column_name FROM information_schema.columns
          WHERE table_name= '#{self.table_name}'").map{|m|  m["column_name"]}
      end

      def table_name
        singular_table_name = CreateGemTutor.to_underscore name
        CreateGemTutor.to_plural singular_table_name
      end

      def set_column_to_attribute
        columns = self.connection.exec("SELECT column_name FROM information_schema.columns
          WHERE table_name= '#{self.table_name}'").map{|m| m['column_name']}

        columns.each{ |column| define_method_attribute(column) }
      end

      def define_method_attribute(name)
        class_eval <<-STR
          def #{name}
            @attributes[:#{name}] || @attributes["#{name}"]
          end

          def #{name}=(value)
            @attributes[:#{name}] = value
          end
        STR
      end

      def to_sql(val)
        case val
        when Numeric
          val.to_s
        when String
          "'#{val}'"
        else
          raise "Can't support #{val.class} to SQL!"
        end
      end

      def count
        self.connection.exec(<<-SQL)[0]['count']
          SELECT COUNT(*) FROM #{self.table_name}
        SQL
      end
    end
  end
end
