# Social Network Tables Design Recipe 

## 1. Extract nouns from the user stories or specification

```
As a social network user,
So I can have my information registered,
I'd like to have a user account with my email address.

As a social network user,
So I can have my information registered,
I'd like to have a user account with my username.

As a social network user,
So I can write on my timeline,
I'd like to create posts associated with my user account.

As a social network user,
So I can write on my timeline,
I'd like each of my posts to have a title and a content.

As a social network user,
So I can know who reads my posts,
I'd like each of my posts to have a number of views.
```

```
Nouns:

user account, username, post, post_title, post_content, post views
```

## 2. Infer the Table Name and Columns

| Record                | Properties          |
| --------------------- | ------------------  |
| account               | username
| post                  | title, content, views

1. Name of the first table (always plural): `accounts` 

    Column names: `username`

2. Name of the second table (always plural): `posts` 

    Column names: `title`, `content`, `view_count`

## 3. Decide the column types.

```
Table: accounts
id: SERIAL
username: text

Table: posts
id: SERIAL
title: text
content: text
view_count: int
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one accounts have many posts? (Yes)
2. Can one posts have many accounts? (No)

You'll then be able to say that:

1. **[accounts] has many [posts]**
2. And on the other side, **[posts] belongs to [accounts]**
3. In that case, the foreign key is in the table [posts]

```
-> Therefore, the foreign key is on the albums table. (account_id)
```

## 4. Write the SQL.

```sql
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  username text
);
s
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

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < albums_table.sql
```
