# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create index]
  before_action :prepare_write, only: %i[new index]
  before_action :find_post, only: %i[edit update destroy]
  before_action :correct_user, only: %i[destroy]

  def new; end

  def create
    @post = current_user.writing_posts.build(post_params)
    if @post.save
      flash[:notice] = I18n.t('customs.posts.create')
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = I18n.t('customs.posts.update')
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = I18n.t('customs.posts.destroy.success')
    else
      flash[:alert] = I18n.t('customs.posts.destroy.failure')
    end
    redirect_back(fallback_location: root_path)
  end

  def index
    @post = current_user.writing_posts.build
    @posts = Post.paginate(page: params[:page]) # for now, future : feed list
    # @feed_items = current_user.feed.paginate(page: params[:page])
    @comment = current_user.comments.build
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def prepare_write
    @post = current_user.writing_posts.build
  end

  def find_post
    @post = Post.find_by_id(params[:id])
  end

  def correct_user
    return if current_user.writing_posts.find_by_id(params[:id])

    flash[:alert] = I18n.t('customs.failures.correct_user')
    redirect_back(fallback_location: root_path)
  end
end
