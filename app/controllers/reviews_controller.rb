class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]

  # GET /reviews or /reviews.json
  def index
    @reviews = Review.all

    # Filter by user email if user_email_search parameter is present
    if params[:user_email_search].present?
      # Use the SQL LIKE operator to find email IDs similar to the search term
      search_term = "%#{params[:user_email_search]}%"
      @users = User.where('email LIKE ?', search_term)
      # Get IDs of matching users
      user_ids = @users.pluck(:id)
      # Filter reviews by user IDs
      @reviews = @reviews.where(user_id: user_ids)
    end

    if params[:event_name_search].present?
      event_search_term = "%#{params[:event_name_search]}%"
      @events = Event.where('event_name LIKE ?', event_search_term)
      event_ids = @events.pluck(:id)

        # Filter reviews by event IDs
      @reviews = @reviews.where(event_id: event_ids)
    end

    # Filter by event name if event_name_search parameter is present
    # if params[:event_name_search].present?
    #   search_term = "%#{params[:event_name_search]}%"
    #   @events = Event.where('event_name LIKE ?', search_term)
    #   event_ids = @events.pluck(:id)
    #
    #   # Filter reviews by event IDs
    #   @reviews = @reviews.where(event_id: event_ids)
    # end
end

  def my_reviews
    puts "hihih"
    puts params[:id]
    puts current_user.id
    if current_user.id != params[:id].to_i
      redirect_to root_url
    end
    @my_reviews = current_user.reviews
  end
  # GET /reviews/1 or /reviews/1.json

  def show
    # STILL IN DOUBT
  end

  # GET /reviews/new
  def new
    # @user = User.find_by_id(params[:id].to_i)
    # if (current_user.id != params[:user_id].to_i)
    #   redirect_to root_url
    # elsif current_user.id == params[:user_id].to_i && @user.tickets.where(id: params[:id])
    #   redirect_to root_url
    # end
    @event = Event.find(params[:event_id])
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to review_url(@review), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to review_url(@review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy!

    respond_to do |format|
      format.html { redirect_to my_reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:rating, :feedback, :user_id, :event_id)
    end
end
