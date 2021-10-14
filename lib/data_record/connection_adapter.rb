module CreateGemTutor
  module DataRecord
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

        def exec(sql)
          @db.exec(sql)
        end
      end
    end
  end
end
