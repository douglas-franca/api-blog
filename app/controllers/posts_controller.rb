class PostsController < ApplicationController
    before_action :authorized, except: %i(index show)
    before_action :set_post, only: %i(show update destroy link_tag unlink_tag tags_vinculadas)
    before_action :set_tag, only: %i(link_tag unlink_tag tags_vinculadas)
    before_action :render_not_authorized, only: %i(update destroy link_tag unlink_tag)

    # GET /posts
    def index
        @posts = Post.all().includes(:likes, :comments, :tags, :user)
        # respond_to do |format|
        #     format.html{ render :index }
        #     format.json{ render json: @posts }
        # end
    end

    # POST /posts
    def create
        @post = Post.new(post_params.merge!(user: @user))
        # @post.user = @user   
        @post.save!
        render action: :show, status: :created 
    end

    # PUT/PATCH /posts/:id
    def update
        @post.update!(post_params)
        render action: :show, status: :ok
    end

    # GET /show/:id
    def show
        # render json: @post
    end

    # DELETE /posts/:id

    def destroy
        @post.destroy
        head :no_content        
    end

    # GET /posts/:id/tags
    def tags_vinculadas
        @tags = @post.tags
        render 'tags/index', status: :ok
    end

    # POST /posts/:id/tag
    def link_tag
        @tag = Tag.find(tag_params[:tag_id])
        @post.tags.push(@tag)
        # render json: @post.tags, status: :ok
        @tags = @post.tags
        render 'tags/index', status: :ok
    end

    #DELETE /posts/:id:tag
    def unlink_tag
        # @tag = @post.tags.find(tag_params[:tag_id])
        
        @post.tags.delete(@tag)
        @tags = @post.tags
        render 'tags/index', status: :ok
    end

    private

        def post_params
            params.require(:post).permit(:title, :description)
        end

        def tag_params
            params.require(:post).permit(:tag_id, tag_id: [])
        end

        def set_post
            @post = Post.find(params[:id])
        end

        def set_tag
            case params[:action]
            when 'link_tag'
                @tag = Tag.find(tag_params[:tag_id])
            when 'unlink_tag'
                @tag = @post.tags.find(tag_params[:tag_id])
            end
        end

        def authorized?
            @user == @post.user
        end
end