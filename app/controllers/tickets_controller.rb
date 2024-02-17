class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]

  # GET /tickets or /tickets.json
  def index
    if current_user.id != params[:id].to_i
      redirect_to root_url
    else
      @tickets = current_user.tickets
    end
    # Regular user view (own bookings)
    # @tickets = current_user.tickets
  end

  def my_bookings
    if current_user.id != params[:id].to_i
      redirect_to root_url
    else
      @tickets = current_user.tickets
      if params[:event_name_search].present?
        # Use the SQL LIKE operator to find email IDs similar to the search term
        search_term = "%#{params[:event_name_search]}%"
        @events = Event.where('event_name LIKE ?', search_term)
        # Get IDs of matching users
        event_ids = @events.pluck(:id)
        # Filter reviews by user IDs
        @tickets = @tickets.where(event_id: event_ids)
      end
      if params[:user_name_search].present?
        user_search_term = "%#{params[:user_name_search]}%"
        @users = User.where('name LIKE ?', user_search_term)
        user_ids = @users.pluck(:id)

        # Filter reviews by event IDs
        @tickets = @tickets.where(user_id: user_ids)
      end
      render :index # Reuse the index view
    end
  end

  def all_bookings
    if !current_user.is_admin?
      redirect_to root_url
    else
      @tickets = Ticket.all
      if params[:event_name_search].present?
        # Use the SQL LIKE operator to find email IDs similar to the search term
        search_term = "%#{params[:event_name_search]}%"
        @events = Event.where('event_name LIKE ?', search_term)
        # Get IDs of matching users
        event_ids = @events.pluck(:id)
        # Filter reviews by user IDs
        @tickets = @tickets.where(event_id: event_ids)
      end
      if params[:user_name_search].present?
        user_search_term = "%#{params[:user_name_search]}%"
        @users = User.where('name LIKE ?', user_search_term)
        user_ids = @users.pluck(:id)

        # Filter reviews by event IDs
        @tickets = @tickets.where(user_id: user_ids)
      end
      render :index
    end
  end

  # GET /tickets/1 or /tickets/1.json
  def show
    if current_user.id != params[:id].to_i
      redirect_to root_url
    end
  end

  # GET /tickets/new
  def new
    @event = Event.find(params[:event_id])
    if current_user.id != params[:user_id].to_i || (@event.event_date < Date.today || (@event.event_date == Date.today && @event.event_start_time < Time.now))
      redirect_to root_url
    end
    @confirmation_number = SecureRandom.random_number(1_000..9_999) # Generates a random integer between 1,000,000 and 9,999,999
    #@event
    @room = Room.find_by_id(@event.room_id)
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
    redirect_to root_url
  end

  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    @event = Event.find(params[:ticket][:event_id])
    @ticket.update(confirmation_number: generate_confirmation_number)
    respond_to do |format|
      if @ticket.save
        @event.update(number_of_seats_left: @event.number_of_seats_left - @ticket.number_of_tickets)
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully created." }
        format.json { render :show, status: :created, location: @ticket }
      else
        puts "dont save"
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    @event = Event.find_by_id(@ticket.event_id)
    @event.update(number_of_seats_left: @event.number_of_seats_left + @ticket.number_of_tickets)
    @ticket.destroy!
    respond_to do |format|
      format.html { redirect_to my_bookings_path, notice: "Ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_params
      params.require(:ticket).permit(:confirmation_number, :room_id, :event_id, :user_id, :number_of_tickets)
    end
    def generate_confirmation_number
      rand(100_000..999_999)
    end

end
