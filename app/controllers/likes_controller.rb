class LikesController < ApplicationController
    before_action :set_post
    before_action :set_comment, only: [ :create_like_comment ]
    before_action :authorized
    before_action :set_like, only: [:destroy_like_post, :destroy_like_comment]
    before_action :render_not_authorized, only: [ :destroy_like_post, :destroy_like_comment]


    # POST post/:id/like
    def create_like_post
        # byebug
        @like = Like.new(likeable: @post)
        @like.user = @user
        @like.save!
        @like.includes(:user)
        render action: :show, status: :created
    end

     # DELETE post/:id/like/:id
    def destroy_like_post
        # byebug
        @like.destroy
        head :no_content
    end



    def create_like_comment
        @like = Like.new(likeable: @comment)
        @like.user = @user
        @like.save!
        render action: :show, status: :created
    end
    

    def destroy_like_comment
        @like.destroy
        head :no_content
    end
    
    private

    def set_post
        @post = Post.find(params[:post_id]) 
    end

    def set_like
        @like = Like.find(params[:id])
    end

    def set_comment
        @comment = @post.comments.find(params[:comment_id])
    end


    def authorized?
        @user == @like.user
    end
end
