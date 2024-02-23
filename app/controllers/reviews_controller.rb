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
end

  def my_reviews
    if current_user.id != params[:id].to_i
      redirect_to root_url
    end
    @my_reviews = current_user.reviews
  end
  # GET /reviews/1 or /reviews/1.json

  def show
    @review = Review.find(params[:id])
    if current_user.id != @review.user_id.to_i
      redirect_to root_url
    end
  end


  # GET /reviews/new
  def new
    @event = Event.find_by_id(params[:event_id])
    @user = User.find_by_id(params[:user_id])
    @current_tickets = current_user.tickets
    size = @current_tickets.where(event_id: @event.id).count

    if ((current_user.id != params[:user_id].to_i) || size == 0 || (@event.event_date > Time.current.utc.to_date || ( @event.event_date == Time.current.utc.to_date && @event.event_start_time.strftime("%H:%M") > Time.current.strftime("%H:%M") )))
      redirect_to root_url
    end
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find_by_id(params[:id])
    if current_user.id != @review.user_id
      redirect_to root_url
    end
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
