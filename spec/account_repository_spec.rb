require 'account_repository'

RSpec.describe AccountRepository do

  def reset_accounts_table
    seed_sql = File.read('spec/seeds_accounts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_accounts_table
  end

  it "gets all accounts" do
    repo = AccountRepository.new

    accounts = repo.all
      
    expect(accounts.length).to eq 2

    expect(accounts[0].id).to eq "1"
    expect(accounts[0].username).to eq "piperrosearmstrong"

    expect(accounts[1].id).to eq "2"
    expect(accounts[1].username).to eq "saritaradia"
  end

  it "gets a single account" do
    repo = AccountRepository.new

    account = repo.find(1)

    expect(account.id).to eq "1"
    expect(account.username).to eq "piperrosearmstrong"
  end

  it "creates an account" do
    repo = AccountRepository.new

    new_account = Account.new
    new_account.username = "abiharold"

    repo.create(new_account)

    all_accounts = repo.all

    expect(all_accounts). to include(
      have_attributes(
        username: new_account.username
      )
    )
  end

  it "deletes an account" do
    repo = AccountRepository.new

    id_to_delete = 1
    repo.delete(id_to_delete)

    all_accounts = repo.all
    expect(all_accounts.length).to eq 1
    expect(all_accounts.first.id).to eq "2"
  end
end
