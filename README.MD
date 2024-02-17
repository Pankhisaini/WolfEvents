# SMP_Event_Management_System

## Hosted Site : http://152.7.177.41:8080/

## User

- **Admin**

  Admin credentials are seeded:
  - &emsp;Username: admin@gmail.com
  - &emsp;Password: 12345678

  Admin functionalities: The admin can create/view/edit/delete events, rooms and users; book a ticket, attend an event and give a review as an attendee; view/delete review; create/view/delete tickets. The admin cannot change his Username and Password. Admin cannot delete his profile.


- **Attendee**- Multiple attendees can signup in the system. Can view/edit/delete his profile.

## Event

- **Admin:**- Can create a future event specifying its' name, category, date, start and end time, ticket price, number of seats (i.e. the event capacity) and the room location. Admin can view all the events including past dated and sold out events.

- **Attendee:**- Can search for an event by applying filters or look up all the events in the 'View events' tab. Only future events and those which are not sold out will be shown to the attendee.

## Event Ticket - Ticket booking

- **Admin:**- Can book/view/cancel a ticket like an attendee and attend them. Booking option will only be available to those events which are in the future and not sold out. Can view all the tickets booked by any user.

- **Attendee:**- Can book/view/cancel a ticket.
- The ticket price and the change in the number of seats is automatically calculated.

## Room

- **Admin:**- Can create/edit/view/delete a room. While creating an event, a room which is booked at that particular time will not be shown in the drop down menu.

## Review

- **Admin:**- Can create/edit/deelet a review written by the admin; can view all the reviews but cannot edit and delete reviews written by any other user; and reviews given by the admin himself seperately.

- **Attendee:**- Can create/edit/delete a review; view all the reviews by any user but can only edit/delete review written by the user itself.
- The review function will only be available when the event has been completed.

# A walk-through to the app

## Login as an Admin

1. Feed the admin credentials
2. To see the admin's profile click on 'View Profile'
3. In this, the admin can edit his profile by clicking the edit option
4. The admin can view all the attendees by clicking the 'View all attendees'
5. In this page, each attendee can be viewed, edited or deleted and create a new user
6. To create an event, click on Add event on the home page or New event in the View events tab
7. In view events tab, edit/delete/view/search options are present
8. To add a room, click on Create room or New Room in View Rooms
9. To view/edit/delete rooms, click on View Rooms
10. To book a ticket, go to the View Events page, click on show button, then click on book a ticket
11. To view the admin's booking, go to My bookings
11. Search/show/write a review is present in this tab
12. Edit/delete ticket can be done by clicking on show
13. 'View all bookings' shows all the tickets booked by the attendees
14. To view Reviews written by the admin, click on 'My Reviews' but to the view the reviews by all the users, click 'View all Reviews'


## Login as an Attendee

1. Signup using the Signup button
2. Login with the same credentials
3. To see the user's profile click on 'View Profile'
4. In this, the user can edit/view/delete his profile by clicking the edit option
5. In view events tab, here the user can book a ticket, the ticket price is already calculated
6. To book a ticket, go to the View Events page, click on show button, then click on book a ticket
7. To view the user's ticket, go to My bookings 
8. Search/show/write a review is present in this tab, also write a review is present in my bookings
9. Edit/delete ticket can be done by clicking on show
10. 'View all bookings' shows all the tickets booked by all the attendee
11. To view Reviews written by the user, click on 'My Reviews' and to the view the reviews by all the users, click 'View all Reviews'
12. The user cannot edit another user's review
- The Home button takes you to the homepage and the Logout button logs the user out, these two buttons are present on each page for the user's convenience

