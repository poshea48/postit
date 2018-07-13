class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  # 1. Set up instance variable for action
  # 2. redirect based on some condition (logged in)

  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
    @categories = Category.all
    # renders new view with form partial
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    if @post.save
      flash[:notice] = "Your post was created"
      redirect_to posts_path
    else
      render :new # uses form partial
    end
  end

  def edit

    # renders edit view with form partial
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "The post was updated"
      redirect_to post_path(@post)
    else
      render :edit # uses form partial
    end
  end

  def vote
    require_user
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
    if @vote.valid?
      flash[:notice] = "Your vote was counted"
    else
      flash[:error] = "You can only vote for on a post once"
    end

    redirect_to :back
  end

  private

  def post_params # mass assigning post parameters strong parameters
    # if user.admin?
      params.require(:post).permit(:title, :url, :description, category_ids: [])#!
    # else
      # params.require(:post).permit(:title, :url)
    # end
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
