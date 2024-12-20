# SKE-Fly-Airline-management-Application

This project implements a Flight Booking System using Java Servlet, JSP, and MySQL. The system allows users to search for flights, book tickets, and manage their reservations. The application also integrates the **Stripe payment gateway** for processing payments during the booking process.

### Key Features:

- **Flight Search**: Users can search for available flights by specifying departure and destination locations, class type, and passenger count.
- **Passenger Details**: After selecting a flight, users provide their passenger details, including name, Aadhar number, date of birth, gender, and mobile number.
- **Booking Confirmation**: Once the passenger details are submitted, a confirmation page is displayed with the flight information and total cost.
- **PNR Check**: Users can check the status of their flight bookings using the PNR (Passenger Name Record) number.
- **Ticket Cancellation**: Users can cancel their bookings using their PNR number, with the corresponding database entry being removed.

### Technologies Used:
- **Backend**: Java, Servlet, JSP
- **Frontend**: HTML, CSS, JSP for dynamic content rendering
- **Database**: MySQL
- **Payment Gateway**: Stripe

## Setup Instructions

### Prerequisites:

1. **Java Development Kit (JDK)**: Ensure you have JDK 8 or higher installed.
2. **Apache Tomcat**: Use Apache Tomcat or another servlet container to deploy the servlets.
3. **MySQL Database**: Ensure MySQL is installed and running. Create a database called `User_Login` and set up the following tables:
   - **flights**
   - **passenger_details**
   - **passenger_details2**

4. **Stripe Account**: You need a Stripe account to integrate the payment gateway. Sign up [here](https://stripe.com) and get your API keys (publishable key and secret key).

### Database Setup:

Run the following SQL commands to set up the database tables:

```sql
CREATE DATABASE User_Login;

USE User_Login;

CREATE TABLE flights (
    flight_number VARCHAR(10) PRIMARY KEY,
    airline VARCHAR(100),
    departure_airport VARCHAR(100),
    arrival_airport VARCHAR(100),
    departure_time DATETIME,
    eco_price INT,
    bus_price INT
);

CREATE TABLE passenger_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    flight_number VARCHAR(10),
    airline VARCHAR(100),
    travel_date DATE,
    from_location VARCHAR(100),
    to_location VARCHAR(100),
    passenger_count INT,
    name VARCHAR(100),
    aadhar VARCHAR(12),
    dob DATE,
    gender VARCHAR(10),
    mobile VARCHAR(15),
    FOREIGN KEY (flight_number) REFERENCES flights(flight_number)
);

CREATE TABLE passenger_details2 (
    pnr VARCHAR(20) PRIMARY KEY,
    flight_number VARCHAR(10),
    airline VARCHAR(100),
    travel_date DATE,
    from_location VARCHAR(100),
    to_location VARCHAR(100),
    passenger_count INT,
    name VARCHAR(100),
    aadhar VARCHAR(12),
    dob DATE,
    gender VARCHAR(10),
    mobile VARCHAR(15)
);
```

### Stripe Payment Gateway Integration:

The system uses the **Stripe Payment Gateway** to handle payments during the flight booking process. Below is a brief explanation of how the integration works.

1. **Stripe Configuration**:
   - Set your Stripe API keys (Publishable and Secret keys) in the appropriate places in your Java code.
   - In the `FlightBookingServlet`, after fetching flight details and calculating the total cost, the system communicates with Stripe’s API to create a payment intent and generate a client secret. This client secret is used to complete the payment on the client-side.

2. **Frontend**:
   - The **Stripe JavaScript library** is included in the booking confirmation page to handle the frontend part of the payment.
   - Users enter their payment details (credit/debit card) on a secure Stripe checkout form.
   - The form communicates with the backend to confirm the payment and proceed with the booking.

3. **Backend**:
   - The backend communicates with the **Stripe API** to create a payment intent and confirm the payment.
   - Once the payment is successful, the booking is finalized and saved to the database, and a confirmation message is displayed to the user.

#### Example of Stripe Integration in `FlightBookingServlet.java`:

```java
// Stripe Configuration
String stripeSecretKey = "your-secret-key";
Stripe.apiKey = stripeSecretKey;

// Create a payment intent
Map<String, Object> paymentIntentParams = new HashMap<>();
paymentIntentParams.put("amount", totalPrice * 100);  // Stripe expects amount in cents
paymentIntentParams.put("currency", "usd");

PaymentIntent paymentIntent = PaymentIntent.create(paymentIntentParams);

// Pass the client secret to the frontend
String clientSecret = paymentIntent.getClientSecret();
request.setAttribute("clientSecret", clientSecret);
```

In the frontend (JSP page), the client secret is used to confirm the payment:

```html
<script src="https://js.stripe.com/v3/"></script>
<script>
  var stripe = Stripe('your-publishable-key');
  var clientSecret = '${clientSecret}';

  var elements = stripe.elements();
  var card = elements.create('card');
  card.mount('#card-element');

  var form = document.getElementById('payment-form');
  form.addEventListener('submit', function(event) {
    event.preventDefault();

    stripe.confirmCardPayment(clientSecret, {
      payment_method: {
        card: card,
        billing_details: {
          name: 'Customer Name'
        }
      }
    }).then(function(result) {
      if (result.error) {
        // Show error message to the user
      } else {
        // Payment succeeded, save booking details
      }
    });
  });
</script>
```

## File Structure:

```
/src
  /Booking
    FlightBookingServlet.java
    PassengerDetailsServlet.java
    PNRCheckServlet.java
    CancelTicketServlet.java
    ...
/webapp
  /WEB-INF
    web.xml
  /jsp
    BookFlight.jsp
    CancelTicket.jsp
    PNRCheck.jsp
    ...
```

## Usage:

1. **Start the Tomcat Server**: Deploy the project to your Tomcat server.
2. **Access the Application**: Open a web browser and go to `http://localhost:8080/` (or the relevant address based on your server setup).
3. **Flight Search**: Use the flight search functionality to find available flights.
4. **Booking & Payment**: Once a flight is selected, enter passenger details and proceed to payment using the Stripe gateway.
5. **PNR Check**: Use the PNR to check your booking details.
6. **Cancel Ticket**: If needed, cancel your booking using the PNR.

## Conclusion:

This project demonstrates the integration of a **Flight Booking System** with a **Stripe Payment Gateway**, allowing users to search flights, book tickets, and make secure payments online. The system also includes features for managing bookings and cancellations using a PNR.

---

Feel free to add any additional sections or modify the content to better suit your project details!
