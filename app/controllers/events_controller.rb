class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  def index
    @events = Event.all
    if params[:name].present?
      @events = @events.where('LOWER(event_name) LIKE ?', "%#{params[:name].downcase}%")
    end
    # Filter events based on parameters
    if params[:category].present?
      @events = @events.where(event_category: params[:category])
    end

    if params[:date].present?
      @events = @events.where(event_date: params[:date])
    end

    if params[:minPrice].present?
      min_price = params[:minPrice].to_i
      @events = @events.where('ticket_price >= ?', min_price)
    end

    if params[:maxPrice].present?
      min_price = params[:maxPrice].to_i
      @events = @events.where('ticket_price <= ?', min_price)
    end
    #puts @events[0].event_name
    respond_to do |format|
      format.html # Render HTML view
      format.json { render json: @events } # Render JSON data
    end
  end


  # GET /events/1 or /events/1.json
  def show
    @event = Event.find(params[:id])
    if !current_user.is_admin? && (@event.event_date < Time.now.utc.to_date || (@event.event_date==Time.now.utc.to_date  && @event.event_start_time.strftime('%H:%M') < Time.current.strftime('%H:%M') || @event.number_of_seats_left <= 0))
      redirect_to root_url
    end
  end

  # GET /events/new
  def new
    if !current_user.is_admin?
      redirect_to root_url
    end
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
    if !current_user.is_admin?
      redirect_to root_url
    end
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)
    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    if !current_user.is_admin?
      redirect_to root_url
    end
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:event_name, :event_category, :event_date, :event_start_time, :event_end_time, :ticket_price, :number_of_seats_left, :room_id)
    end
end
