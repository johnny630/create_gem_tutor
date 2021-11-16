module ActiveRecord
  module ConnectionAdapter
    class PostgreSQLAdapter
      def initialize(host, user, dbname, password)
        require 'pg'
        @db = PG.connect(
            host: host,
            user: user,
            password: password,
            dbname: dbname
          )
      end

      def execute(sql)
        @db.exec(sql)
      end

      def schema(table_name)
        self.execute("SELECT column_name FROM information_schema.columns
          WHERE table_name= '#{table_name}'").map{|m|  m["column_name"]}
      end
    end

    class SQLiteAdapter
      def initialize(dbname)
        require 'sqlite3'
        @db = SQLite3::Database.new dbname
      end

      def execute(sql)
        @db.execute(sql)
      end

      def schema(table_name)
        @db.table_info(table_name).map{ |row| row['name'] }
      end
    end
  end
end
