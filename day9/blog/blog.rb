require 'sinatra'

class Post
	attr_reader :id, :title, :body, :author, :date
	def initialize(id, title, body, author, date)
		@id = id
		@title = title
		@body = body
		@author = author
		@date = date		
	end	
end

class Comment
	attr_reader :id, :body, :author, :post_id
  def initialize(id, body, author, post_id)
  	@id = id
  	@body = body
  	@author = author
  	@post_id = post_id
  end
end

comments = [
  Comment.new(1, 'I really like this post', 'Gabriel', 1),
  Comment.new(2, 'I really like this post', 'Gabriel', 1)
]

posts =[
	Post.new(1, "Post 1", "Content", "Me", "7th of August"),
	Post.new(2, "Post 2", "Content", "Me", "7th of August"),
	Post.new(3, "Post 3", "Content", "Me", "7th of August")
]

def create_comment(id, params)
  Comment.new(id, params[:comment] , params[:author], params[:id].to_i)
end

def find_comments_for_post(comments,id)
  comments.select{|comment| comment.post_id == id.to_i}
end

def find_post(posts,id)
  posts.select {|post| post.id == id.to_i}.first
end

def comment_delete(comments,comment_id)
  comments.delete_if do |comment|
    comment.id == comment_id
  end
  comments
end


get '/' do
  @posts = posts
  erb :index
end

get '/show/:id' do #'/show' if <li><a href="/show?id=<%= post.id %>">
  @post = find_post(posts,params[:id])
  @comments = find_comments_for_post(comments,params[:id])
  erb :show
end

post '/show/:id' do
  #params.to_s

   @post = find_post(posts,params[:id])
   @comments = find_comments_for_post(comments,params[:id])
   if @comments.empty?
      new_id = 1
   else
      new_id = comments.last.id + 1
   end
   @comments << create_comment(new_id, params)
   comments = @comments 

   erb :show
end

get '/show/:id/delete' do
  @post = find_post(posts,params[:id])
  @comments = comment_delete(comments,params[:comment_id].to_i)
  comments = @comments
  redirect "/show/#{params[:id]}"
end

