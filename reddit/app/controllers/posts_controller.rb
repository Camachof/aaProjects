class PostsController < ApplicationController
  before_action :is_author?, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
    render :index
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    # @post.param = paramvalue => @post.title = title, @post...
    # @post.sub_ids=([    ])
    # new ones -> find_or_create   [1,2] [2,3] --> create posting 3
    # ones missing -> destroy    [1,2] [2,3] --> destroy posting 1

    @post.author_id = current_user.id

    if @post.save
      fail
      redirect_to sub_url(params[:current_sub_id])
    else
      flash.notice = @post.errors.full_messages.join(", ")
      redirect_to subs_url
    end

  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
    render :edit
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      render :edit
    end
  end

  def destroy
    @post_to_destroy = Post.find(params[:id])
    @post_to_destroy.destroy
    redirect_to posts_url
  end

  private
  def is_author?
    @post = Post.find(params[:id])
    current_user == @post.author
  end

  def post_params
    params.require(:post).permit(:title, :content, sub_ids: [])
  end

end
