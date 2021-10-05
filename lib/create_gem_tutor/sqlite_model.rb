require 'sqlite3'
require 'create_gem_tutor/support'

DB = SQLite3::Database.new 'just_do.db'

module CreateGemTutor
  module Model
    class SQLite
      def initialize(data = nil)
        @hash = data
      end

      def method_missing(attr, *args)
        attrs = self.class.schema
        attr = attr.to_s.gsub('=', '')
        if attrs.key?(attr)
          self.class.define_attr(attrs)
          val = args.empty? ? self.send(attr) : self.send("#{attr}=", args[0])
          val
        else
          super
        end
      end

      def self.define_attr(attrs)
        attrs.keys.each do |attr|
          add_method_to_get(attr)
          add_method_to_set(attr)
        end
      end

      def self.add_method_to_get(attr)
        define_method attr do
          self[attr.to_s]
        end
      end

      def self.add_method_to_set(attr)
        define_method "#{attr}=" do |arg|
          self[attr.to_s] = arg
        end
      end

      def self.to_sql(value)
        case value
        when Numeric
          value.to_s
        when String
          "'#{value}'"
        else
          raise("Can't support #{val.class} to SQL!")
        end
      end

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

      def self.create(values)
        # 先刪除掉id
        values.delete :id
        keys = schema.keys - ['id']

        vals = keys.map do |key|
          values[key.to_sym] ? to_sql(values[key.to_sym]) : 'null'
        end

        DB.execute <<-SQL
          INSERT INTO #{table} (#{keys.join ', '})
          VALUES (#{vals.join ', '})
        SQL

        data = Hash[keys.zip(values.values)]
        sql = "SELECT last_insert_rowid();"
        data['id'] = DB.execute(sql)[0][0]
        self.new data
      end

      def self.find(id)
        row = DB.execute <<-SQL
          select #{schema.keys.join(',')} from #{table}
          where id = #{id};
        SQL

        data = Hash[schema.keys.zip row[0]]
        self.new data
      end

      def self.all
        rows = DB.execute <<-SQL
          select #{schema.keys.join(',')} from #{table};
        SQL

        rows.map do |row|
          data = Hash[schema.keys.zip row]
          self.new data
        end
      end

      def [](name)
        @hash[name.to_s]
      end

      def []=(name, value)
        @hash[name.to_s] = value
      end

      def save!
        unless @hash['id']
          # 如果沒有 ID 就當作是要新增新的資料
          self.class.create(@hash)
          return true
        end

        fields = @hash.map { |key, val| "#{key}=#{self.class.to_sql(val)}" }.join(', ')
        DB.execute <<-SQL
            UPDATE #{self.class.table}
            SET #{fields}
            WHERE id = #{@hash["id"]}
        SQL

        true
      end

      def save
        self.save! rescue false
      end

      def self.count
        DB.execute(<<-SQL)[0][0]
            SELECT COUNT(*) FROM #{table}
        SQL
      end
    end
  end
end
