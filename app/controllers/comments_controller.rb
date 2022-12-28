class CommentsController < ApplicationController
    before_action :set_post
    before_action :set_comment, except: %i(index create)
    before_action :authorized, except: %i(index show)
    before_action :render_not_authorized, only: %i(update destroy)

    def index
        @comments = @post.comments
    end

    def show
        # render json: @post
    end

    def create
        @comment = @post.comments.new(comment_params)
        @comment.user = @user
        @comment.save!
        render action: :show, status: :created 
    end

    def update
        @comment.update!(comment_params)
        render action: :show, status: :ok
    end

    def destroy
        @comment.destroy
        head :no_content        
    end

    private
        def comment_params
            params.require(:comment).permit(:text)
        end

        def set_post
            @post = Post.find(params[:post_id])
        end

        def set_comment
            @comment = @post.comments.find(params[:id])
        end

        def authorized?

            case params[:action]
                when 'destroy'
                    @user == @post.user || @user == @comment.user
                when 'update'
                    @user == @comment.user
            end
        end
end
