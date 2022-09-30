# Social Network Model and Repository Classes Design Recipe


## 1. Design and create the Table


## 2. Create Test SQL seeds

```sql

-- seeds_accounts.sql

TRUNCATE TABLE accounts RESTART IDENTITY; 

INSERT INTO accounts (username) VALUES ('piperrosearmstrong');
INSERT INTO accounts (username) VALUES ('saritaradia');

-- seeds_posts.sql

TRUNCATE TABLE posts RESTART IDENTITY; 

INSERT INTO posts (title, content, view_count, account_id) VALUES ('title', 'content', 2, 1);
INSERT INTO posts (title, content, view_count, account_id) VALUES ('title2', 'content2', 10, 1);
```

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

```ruby
# Table name: accounts

# Model class
# (in lib/account.rb)

class Account
end

# Repository class
# (in lib/account_repository.rb)

class AccountRepository
end

# Table name: posts

# Model class
# (in lib/post.rb)

class Post
end

# Repository class
# (in lib/post_repository.rb)

class PostRepository
end
```

## 4. Implement the Model class

```ruby
# Table name: accounts

# Model class
# (in lib/account.rb)

class Account

  attr_accessor :id, :username
end

# Table name: posts

# Model class
# (in lib/post.rb)

class Post

  attr_accessor :id, :title, :content, :view_count, :account_id
end

```

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# Table name: accounts

# Repository class
# (in lib/account_repository.rb)

class AccountRepository

  def all
    # SELECT id, username FROM accounts;

  end

  def find(id)
    # SELECT id, username FROM accounts WHERE id = $1;

  end

  def create(account)
    # INSERT INTO albums (username) VALUES($1);
  end

  def delete(account)
    # DELETE FROM albums WHERE id = $1;
  end
end

# Table name: posts

# Repository class
# (in lib/post_repository.rb)

class PostRepository

  def all
    # SELECT id, title, content, view_count, account_id FROM posts;

  end

  def find(id)
    # SELECT id, title, content, view_count, account_id FROM posts WHERE id = $1;

  end

  def create(post)
    # INSERT INTO posts (title, content, view_count, account_id) VALUES($1, $2, $3, $4);
  end

  def delete(post)
    # DELETE FROM posts WHERE id = $1;
  end
end
```

Table: accounts
id: SERIAL
username: text

Table: posts
id: SERIAL
title: text
content: text
view_count: int
account_id: int

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all accounts

repo = AccountRepository.new

accounts = repo.all

accounts.length # =>  2

accounts[0].id # =>  1
accounts[0].username # =>  "piperrosearmstrong"

accounts[1].id # =>  2
accounts[1].username # =>  "saritaradia"

# 2
# Get a single account

repo = AccountRepository.new

account = repo.find(1)

account.id # =>  1
account.username # =>  "piperrosearmstrong"

# 3
# Create an account

repo = AccountRepository.new

new_account = Account.new
new_account.username # => "abiharold"

repo.create(new_account)

all_accounts = repo.all

expect(all_accounts). to include(
  have_attributes(
    username: new_account.username
  )
)

# 4
# Delete an account

repo = AccountRepository.new

id_to_delete = 1
repo.delete(id_to_delete)

all_accounts = repo.all
all_accounts.length # => 1
all_accounts.first.id # => 2

# 5
# Get all posts

repo = PostRepository.new

posts = repo.all

posts.length # =>  2

posts[0].id # =>  1
posts[0].title # =>  "title"
posts[0].content # =>  "content"
posts[0].view_count # =>  2
posts[0].account_id # =>  1

posts[1].id # =>  2
posts[1].username # =>  "title2"
posts[1].content # =>  "content2"
posts[1].view_count # =>  10
posts[1].account_id # =>  1

# 6
# Get a single post

repo = PostRepository.new

post = repo.find(1)

post.id # =>  1
post.title # =>  "title"
post.content # =>  "content"
post.view_count # =>  2
post.account_id # =>  1

# 7
# Create a post

repo = PostRepository.new

new_post = Post.new
new_post.title # => "title3"
new_post.content # => "content3"
new_post.view_count # => 5
new_post.account_id # => 2

repo.create(new_post)

all_posts = repo.all

expect(all_posts).to include(
  have_attributes(
    title: new_post.title,
    content: new_post.content,
    view_count: "5",
    account_id: "2"
  )
)

# 8
# Delete a post

repo = PostRepository.new

id_to_delete = 1
repo.delete(id_to_delete)

all_posts = repo.all
all_posts.length # => 1
all_posts.first.id # => 2
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_accounts_table
  seed_sql = File.read('spec/seeds_accounts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe AccountRepository do
  before(:each) do 
    reset_accounts_table
  end

  # (your tests will go here).
end





def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

