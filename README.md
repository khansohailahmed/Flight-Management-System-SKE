# Flight Management System

A complete web-based Flight Management System built with Java, JSP, Servlets, MySQL, and Stripe integration for booking flights, user authentication, flight status checks, and more. This project showcases an advanced, real-world implementation of various functionalities such as flight bookings, email notifications, payment processing, and AI chatbot integration.

## Project Overview

The Flight Management System is designed to manage flight bookings for users. The system enables users to search for flights, make bookings, and receive flight details. It also integrates email functionality for booking confirmation and uses Stripe for secure online payment processing.

The project aims to provide a user-friendly interface and a seamless booking experience, along with a chatbot integration to assist with inquiries, improving user engagement.

## Technologies Used

- **Frontend:**
  - HTML, CSS, and JavaScript
  - JSP (JavaServer Pages)
  - Bootstrap (for responsive design)
  
- **Backend:**
  - Java (JSP, Servlets)
  - MySQL Database
  - Stripe API for payment integration
  - JavaMail API for email notifications
  - Google Dialogflow for Chatbot integration
  
- **Version Control:**
  - Git (for version control)
  
- **Build Tools:**
  - Apache Tomcat (for hosting the web application)
  
- **Libraries:**
  - Stripe.js (for handling Stripe payments)
  - jQuery (for AJAX requests)

## Features

### 1. **User Authentication and Session Management**
   - Users can register and log in to manage their bookings.
   - Session management ensures secure access to booking pages.

### 2. **Flight Search and Booking**
   - Users can search for flights based on departure and arrival cities, travel date, class (economy/business), and the number of passengers.
   - The system displays available flights with detailed information like flight number, airline, and departure time.

### 3. **Passenger Details Collection**
   - After selecting a flight, users input personal details for each passenger, including name, email, mobile number, Aadhaar, date of birth, and gender.

### 4. **Email Integration**
   - Upon successful flight booking, the system sends a confirmation email to the user with booking details.
   - The email functionality is implemented using **JavaMail API** for sending automated booking confirmation emails to users.

### 5. **Stripe Payment Integration**
   - Secure payment handling using **Stripe API**.
   - The total booking price is calculated dynamically based on the selected flight and passenger details, and users can complete the payment process directly via Stripe’s secure checkout system.

### 6. **AI Chatbot Integration**
   - An AI-powered chatbot helps users with flight-related inquiries, providing instant support and answers to frequently asked questions.
   - **Google Dialogflow** was used to integrate the chatbot into the system, improving user interaction and engagement.

### 7. **Flight Status Check**
   - Users can check the status of flights using flight numbers to see real-time information about departures, arrivals, and delays.

### 8. **Responsive Design**
   - The system features a responsive design that adapts to various screen sizes, making it accessible on both desktop and mobile devices.

## How to Run

### Prerequisites:
- **JDK (Java Development Kit)**: Version 8 or later
- **MySQL Database**: Installed and running
- **Apache Tomcat**: Version 9 or later
- **Stripe Account**: To configure payment API keys

### Steps:
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/flight-management-system.git
   ```
2. Navigate to the project directory:
   ```bash
   cd flight-management-system
   ```
3. Configure your MySQL database by running the SQL script provided in the `db` folder.
4. Deploy the application to Apache Tomcat by copying the project files into the `webapps` directory.
5. Configure your **Stripe** API keys and **JavaMail** credentials in the `web.xml` and relevant Servlet classes.
6. Start your Apache Tomcat server.
7. Open a web browser and visit `http://localhost:8080/` to access the application.

## Project Structure

```
/flight-management-system
├── /src
│   ├── /servlets
│   │   ├── FlightBookingServlet.java
│   │   ├── UserLoginServlet.java
│   │   ├── PaymentServlet.java
│   │   └── ...
│   ├── /db
│   │   ├── schema.sql
│   │   └── ...
│   ├── /jsp
│   │   ├── BookFlight.jsp
│   │   ├── UserLogin.jsp
│   │   └── ...
│   └── /utils
│       └── EmailUtils.java
│       └── PaymentUtils.java
├── /webapps
│   └── /flight-management-system
└── /resources
    └── /chatbot
        ├── dialogflow.json
        └── ...
```

## Skills Showcased

- **Full-Stack Development**: Experience in designing and building a complete flight booking system using **Java**, **JSP**, **Servlets**, and **MySQL**.
- **Payment Gateway Integration**: Implemented **Stripe API** for secure and seamless payment processing.
- **Email Integration**: Used **JavaMail API** to send automated email notifications, including flight booking confirmations.
- **AI Chatbot**: Integrated an **AI-powered chatbot** using **Google Dialogflow**, offering real-time customer support and handling flight-related queries.
- **Responsive Design**: Ensured the system is mobile-friendly and performs well across all screen sizes using **CSS** and **Bootstrap**.
- **Database Management**: Created and managed a MySQL database schema to store user and flight data effectively.
- **User Authentication**: Implemented **login** and **registration** features using **sessions** to ensure secure access to the application.
- **Error Handling and Validation**: Incorporated client-side and server-side validation to prevent issues like incorrect booking or form submissions.

## Acknowledgements

- **Stripe** for providing a secure and easy-to-use payment gateway.
- **Google Dialogflow** for the AI chatbot integration.
- **JavaMail API** for automating email notifications.

