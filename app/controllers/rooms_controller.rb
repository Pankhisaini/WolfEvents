class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy ]

  # GET /rooms or /rooms.json
  def index
    if !current_user.is_admin?
      redirect_to root_url
    end
    @rooms = Room.all
  end


  # GET /rooms/1 or /rooms/1.json
  def show
    if !current_user.is_admin?
      redirect_to root_url
    end
  end

  # GET /rooms/new
  def new
    if !current_user.is_admin?
      redirect_to root_url
    end
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
    if !current_user.is_admin?
      redirect_to root_url
    end
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to room_url(@room), notice: "Room was successfully created." }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to room_url(@room), notice: "Room was successfully updated." }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy!

    respond_to do |format|
      format.html { redirect_to rooms_url, notice: "Room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def available_rooms
    date = params[:date]
    start_time = params[:start_time]
    end_time = params[:end_time]

    start_time = Time.parse(start_time)
    end_time = Time.parse(end_time)
    date = Date.parse(date)

    @available_rooms = []
    @all_rooms = Room.all

    @all_rooms.each do |room|
      events = room.events
      is_room_available = true

      events.each do |event|
        event_start_time = Time.parse(event.event_start_time.strftime('%H:%M'))
        event_end_time = Time.parse(event.event_end_time.strftime('%H:%M'))
        event_date = event.event_date
        if (event_date == date && !(start_time >= event_end_time || end_time <= event_start_time))
          is_room_available = false
          break
        end
      end
      @available_rooms << room if is_room_available
    end
    render json: @available_rooms
  end



  private
    # Helper method to check if a room is available for the given time slot
    def room_available?(room, start_datetime, end_datetime)
    # Check if there are any events booked for the room during the given time slot
      room.events.none? do |event|
        event_start_datetime = DateTime.parse("#{event.event_date} #{event.event_start_time}")
        event_end_datetime = DateTime.parse("#{event.event_date} #{event.event_end_time}")
        event_start_datetime <= end_datetime && event_end_datetime >= start_datetime
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:room_location, :room_capacity)
    end
end
