class LikesController < ApplicationController
    before_action :authorized,  except: [ :index, :index_comment ]
    before_action :set_post, except: [ :destroy_like_comment ]
    before_action :set_comment, only: [ :create_like_comment, :index_comment, :destroy_like_comment ]
    before_action :set_post_like, only: [:destroy_like_post]
    before_action :set_comment_like, only: [ :destroy_like_comment ]
    before_action :render_not_authorized, only: [ :destroy_like_post, :destroy_like_comment]

    def index
        @likes = @post.likes
        render action: :index, status: :ok
    end

    def index_comment
        @likes = @comment.likes
        render action: :index, status: :ok
    end

    # POST post/:id/like
    def create_like_post
        # byebug
        @like = Like.new(likeable: @post)
        @like.user = @user
        @like.save!
        render action: :show, status: :created
    end

     # DELETE post/:post_id/like/:id
    def destroy_like_post
        # byebug
        @like.destroy
        head :no_content
    end

    # POST post/:post_id/comment/:comment_id/like
    def create_like_comment
        @like = Like.new(likeable: @comment)
        @like.user = @user
        @like.save!
        render action: :show, status: :created
    end
    
    # POST post/:post_id/comment/:comment_id/like/:id
    def destroy_like_comment
        @like.destroy
        head :no_content
    end
    
    private

    def set_post
        @post = Post.find(params[:post_id])
    end

    def set_post_like
        @like = Post.find(params[:post_id]).likes.find_by(user_id: @user.id)
    end

    def set_comment_like
        @like = Comment.find(params[:comment_id]).likes.find_by(user_id: @user.id)
    end

    def set_comment
        @comment = Comment.find(params[:comment_id])
    end

    def authorized?
        @user == @like.user
    end
end
