class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def sql_insert(db_table, fields_name, records_list)
    values = records_list.map { |record| 
      "(#{ record.map {|field, value| "#{ActiveRecord::Base.connection.quote(value)}"}.join(',') },'#{Time.now}','#{Time.now}')"
    }.join(',')
    ActiveRecord::Base.connection.update("INSERT INTO #{db_table} (#{fields_name.join(', ')}, created_at, updated_at) VALUES #{values}")
  end
  
end