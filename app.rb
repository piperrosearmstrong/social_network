require_relative 'lib/database_connection'

DatabaseConnection.connect('social_network')

sql = 'SELECT id, title FROM albums;'
result = DatabaseConnection.exec_params(sql, [])

result.each do |record|
  p record
end