class UsersController < ApplicationController
  before_action :authorized, only: %i(update destroy show)
  # before_action :set_user, only: %i(show update destroy)

  # POST /user or /user.json
  def create
    @user = User.create(user_params)

    if @user.valid?
      @token = encode_token({user_id: @user.id})
      # render json: {user: @user, token: token}
      render :show, status: :created
    else
      render json: {error: 'Invalid username  or password'}
    end

    # respond_to do |format|
    #   @user.save!
    #     format.html { redirect_to user_url(@user), notice: "User was successfully created." }
    #     format.json { render :show, status: :created, location: @user }
    # end
  end

  # POST /login
  def login
    @user = User.find_by(email: params[:email])
    # byebug

    if @user && @user.authenticate(params[:password])
      @token = encode_token({user_id: @user.id})
      # byebug
      render :show
    else
      render json: {error: 'Invalid Username or Password!'}
    end
  end

  # GET /user/auto_login or /user/1.json
  def show
    # render json: @user
    render :show
  end

  # PATCH/PUT /user/1 or /user/1.json
  def update
      @user.update!(user_params)
      render :show, status: :ok
    
  end

  # DELETE /user/1 or /user/1.json
  def destroy
    @user.destroy
    head :no_content 
  end


  private

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
