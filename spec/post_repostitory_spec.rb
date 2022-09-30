require 'post_repository'

RSpec.describe PostRepository do
  def reset_posts_table
    seed_sql = File.read('spec/seeds_posts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
  end
  
  before(:each) do 
    reset_posts_table
  end

  it "gets all posts" do
    repo = PostRepository.new

    posts = repo.all

    expect(posts.length).to eq 2

    expect(posts[0].id).to eq "1"
    expect(posts[0].title).to eq "title"
    expect(posts[0].content).to eq "content"
    expect(posts[0].view_count).to eq "2"
    expect(posts[0].account_id).to eq "1"

    expect(posts[1].id).to eq "2"
    expect(posts[1].title).to eq "title2"
    expect(posts[1].content).to eq "content2"
    expect(posts[1].view_count).to eq "10"
    expect(posts[1].account_id).to eq "1"
  end

  it "gets a single post" do
    repo = PostRepository.new

    post = repo.find(1)

    expect(post.id).to eq "1"
    expect(post.title).to eq "title"
    expect(post.content).to eq "content"
    expect(post.view_count).to eq "2"
    expect(post.account_id).to eq "1"
  end

  it "creates a post" do
    repo = PostRepository.new

    new_post = Post.new
    new_post.title = "title3"
    new_post.content = "content3"
    new_post.view_count = 5
    new_post.account_id = 2

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
  end

  it "deletes a post" do
    repo = PostRepository.new

    id_to_delete = 1
    repo.delete(id_to_delete)

    all_posts = repo.all
    expect(all_posts.length).to eq 1
    expect(all_posts.first.id).to eq "2"
  end
end