CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  username text
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  view_count text, 
  account_id int,
  constraint fk_account foreign key(account_id)
    references accounts(id)
    on delete cascade
);