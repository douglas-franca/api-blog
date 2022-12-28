class TagsController < ApplicationController
    before_action :set_tags, only: %i(show update destroy)

    # GET /tags
    def index
        if params[:name].present?
            @tags = Tag.starting_with(params[:name])
        else
            @tags = Tag.all()
        end
    end

    # CREATE POST/tags
    def create
        @tag = Tag.new(tags_params)
        @tag.save!
        render action: :show, status: :ok
    end

    # PUTH/PATCH /tags/id
    def update
        @tag.update!(tags_params)
        render action: :show, status: :ok
    end

    # GET show/:id
    def show
        # render json: @post
    end

    def destroy
        @tag.destroy
        head :no_content
    end

    # Ações privadas, para serem reutilizadas em outras ações
    private

    def tags_params
        params.require(:tag).permit(:name)
    end

    def set_tags
        @tag = Tag.find(params[:id])        
    end

end
