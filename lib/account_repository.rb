require_relative "./account"

class AccountRepository
  def all
    accounts = []

    sql = 'SELECT id, username FROM accounts;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |record|
      account = Account.new
      account.id = record['id']
      account.username = record['username']
      accounts << account
    end
    return accounts
  end

  def find(id)
    sql = 'SELECT id, username FROM accounts WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]

    account = Account.new
    account.id = record['id']
    account.username = record['username']

    return account
  end

  def create(account)
    sql = 'INSERT INTO 
              accounts (username) 
              VALUES($1);'
    sql_params = [account.username]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def delete(account)
    sql = 'DELETE FROM accounts WHERE id = $1;'
    sql_params = [account]

    DatabaseConnection.exec_params(sql, sql_params)
  end
end