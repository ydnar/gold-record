require 'active_record/connection_adapters/mysql_adapter'

module ActiveRecord
  module ConnectionAdapters
    class MysqlAdapter < AbstractAdapter
      
      # MySQL can store UUIDs in binary(16) instead of a blob column.
      def type_to_sql(type, limit = nil, precision = nil, scale = nil)
        # New functionality to handle limit on binary columns
        return "binary(#{limit})" if type.to_s == 'binary' && !limit.blank?

        # Exact implementation from ActiveRecord 2.3.4
        return super unless type.to_s == 'integer'

        case limit
        when 1; 'tinyint'
        when 2; 'smallint'
        when 3; 'mediumint'
        when nil, 4, 11; 'int(11)'  # compatibility with MySQL default
        when 5..8; 'bigint'
        else raise(ActiveRecordError, "No integer type has byte size #{limit}")
        end
      end
      
      def change_integer_primary_key_to_uuid(table, column = :id)
        table = table.to_s
        column = column.to_s
        execute "ALTER TABLE #{table} ADD COLUMN #{column}_new BINARY(16) FIRST"
        execute "UPDATE #{table} SET #{column}_new = #{column}"
        execute "ALTER TABLE #{table} DROP COLUMN #{column}"
        execute "ALTER TABLE #{table} CHANGE COLUMN #{column}_new #{column} BINARY(16) FIRST"
      end

      def change_uuid_to_integer_primary_key(table, column = :id)
        table = table.to_s
        column = column.to_s
        execute "ALTER TABLE #{table} CHANGE COLUMN #{column} #{column}_old BINARY(16)"
        execute "ALTER TABLE #{table} ADD COLUMN #{column} int(11)"
        execute "UPDATE #{table} SET #{column} = #{column}_old"
        execute "ALTER TABLE #{table} DROP COLUMN #{column}_old"
        execute "ALTER TABLE #{table} CHANGE COLUMN #{column} #{column} #{NATIVE_DATABASE_TYPES[:primary_key]} FIRST"
      end

      def change_integer_to_uuid(table, column = :id)
        table = table.to_s
        column = column.to_s
        execute "ALTER TABLE #{table} ADD COLUMN #{column}_new BINARY(16)"
        execute "UPDATE #{table} SET #{column}_new = #{column}"
        execute "ALTER TABLE #{table} DROP COLUMN #{column}"
        execute "ALTER TABLE #{table} CHANGE COLUMN #{column}_new #{column} BINARY(16) AFTER id"
      end

      def change_uuid_to_integer(table, column = :id)
        table = table.to_s
        column = column.to_s
        execute "ALTER TABLE #{table} CHANGE COLUMN #{column} #{column}_old BINARY(16)"
        execute "ALTER TABLE #{table} ADD COLUMN #{column} int(11) AFTER id"
        execute "UPDATE #{table} SET #{column} = #{column}_old"
        execute "ALTER TABLE #{table} DROP COLUMN #{column}_old"
      end
    end
  end
end
