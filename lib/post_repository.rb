require_relative './post'

class PostRepository
  def all
    posts = []
    
    sql = 'SELECT id, title, content, view_count, account_id FROM posts;'
    result_set = DatabaseConnection.exec_params(sql, [])
    result_set.each do |record|
      post = Post.new
      post.id = record['id']
      post.title = record['title']
      post.content = record['content']
      post.view_count = record['view_count']
      post.account_id = record['account_id']
      posts << post
    end
    return posts
  end

  def find(id)
    sql = 'SELECT id, title, content, view_count, account_id FROM posts WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]

    post = Post.new
    post.id = record['id']
    post.title = record['title']
    post.content = record['content']
    post.view_count = record['view_count']
    post.account_id = record['account_id']

    return post
  end

  def create(post)
    sql = 'INSERT INTO 
            posts (title, content, view_count, account_id) 
            VALUES($1, $2, $3, $4);'
    sql_params = [post.title, post.content, post.view_count, post.account_id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def delete(post)
    sql = 'DELETE FROM posts WHERE id = $1;'
    sql_params = [post]

    DatabaseConnection.exec_params(sql, sql_params)
  end
end