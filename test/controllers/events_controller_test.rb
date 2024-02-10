require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test "should get new" do
    get new_event_url
    assert_response :success
  end

  test "should create event" do
    assert_difference("Event.count") do
      post events_url, params: { event: { event_category: @event.event_category, event_date: @event.event_date, event_end_time: @event.event_end_time, event_name: @event.event_name, event_start_time: @event.event_start_time, number_of_seats_left: @event.number_of_seats_left, room_id: @event.room_id, ticket_price: @event.ticket_price } }
    end

    assert_redirected_to event_url(Event.last)
  end

  test "should show event" do
    get event_url(@event)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_url(@event)
    assert_response :success
  end

  test "should update event" do
    patch event_url(@event), params: { event: { event_category: @event.event_category, event_date: @event.event_date, event_end_time: @event.event_end_time, event_name: @event.event_name, event_start_time: @event.event_start_time, number_of_seats_left: @event.number_of_seats_left, room_id: @event.room_id, ticket_price: @event.ticket_price } }
    assert_redirected_to event_url(@event)
  end

  test "should destroy event" do
    assert_difference("Event.count", -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end
end
