class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create]
  before_action :set_user, only: %i[ show edit update destroy ]
  # GET /users or /users.json
  def index
    if !current_user.is_admin?

      redirect_to root_url
    end

    @users = User.all
    if params[:show].present?
      render json:@users
    end
    if params[:event_name].present?
      @event = Event.where("event_name LIKE ?", "%#{params[:event_name]}%").first

      if @event.present?
        @tickets = @event.tickets
        user_ids = @tickets.pluck(:user_id)
        @attendees = User.where(id: user_ids)
        @users = @attendees
      else
        @users = []
      end
    end
  end

  # GET /users/1 or /users/1.json
  def show
    if current_user.id != params[:id].to_i && !current_user.is_admin?
      redirect_to root_url
    end
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    if !current_user.nil? && !current_user.is_admin?
      redirect_to root_url
    end
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if current_user.id != params[:id].to_i && !current_user.is_admin?
      redirect_to root_url
    end
  end

  # POST /users or /users.json
  def user_url(user)
    if !current_user.is_admin?
      redirect_to root_url
    end
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        # if current_user.is_admin
        #   format.html { redirect_to users_path, notice: "User was successfully created." }
        # else
        format.html { redirect_to root_url, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if current_user.is_admin? && @user.is_admin?
        if @user.update(user_params_without_password)
          format.html { redirect_to profile_path, notice: "User was successfully updated." }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        if @user.update(user_params)
          format.html { redirect_to profile_path, notice: "User was successfully updated." }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!
    if !current_user.is_admin? && !@user.is_admin?
      reset_session
    end

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :password, :name, :phone_number, :address, :credit_card_information)
  end

  def user_params_without_password
    params.require(:user).permit(:name, :phone_number, :address, :credit_card_information)
  end
end
