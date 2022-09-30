TRUNCATE TABLE accounts, posts RESTART IDENTITY CASCADE; 

INSERT INTO accounts (username) VALUES ('piperrosearmstrong');
INSERT INTO accounts (username) VALUES ('saritaradia');

INSERT INTO posts (title, content, view_count, account_id) VALUES ('title', 'content', 2, 1);