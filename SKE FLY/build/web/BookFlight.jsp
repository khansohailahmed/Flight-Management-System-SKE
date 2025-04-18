<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% 
    // Check if the user is logged in
    Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn"); 
    if (isLoggedIn == null || !isLoggedIn) { 
%>
    <script> 
        alert("Please login to proceed with booking a flight."); 
        window.location.href = "Userlogin.jsp"; // Redirect to login page 
    </script>
<% 
    return; // Stop further processing 
} 
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Flight</title>
    <script src="https://js.stripe.com/v3/"></script>
    <style>
        /* Your existing CSS styles */
        body {
            font-family: 'Roboto', Arial, sans-serif;
            background: #ffffff; /* Set plain white background */
            margin: 0;
            padding: 0;
            color: #333;
        }

        .container {
            max-width: 750px;
            margin: 40px auto;
            padding: 25px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        h2 {
            text-align: center;
            color: #333;
            font-size: 1.8em;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            font-size: 1em;
            color: #444;
            display: block;
            margin-bottom: 8px;
        }

        input, select, button {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }

        input:focus, select:focus {
            border-color: #4facfe;
            outline: none;
            box-shadow: 0 0 6px rgba(79, 172, 254, 0.6);
        }

        button {
            background-color: #28a745; /* Set buttons to green */
            color: white;
            font-size: 1em;
            font-weight: bold;
            cursor: pointer;
            border: none;
            margin-top: 10px;
            transition: all 0.3s ease;
            border-radius: 8px; /* Added for rounded button corners */
        }

        button:hover {
            background-color: #218838; /* Slightly darker green for hover effect */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .extra-details, .price-details {
            margin-top: 20px;
            padding: 15px;
            background: #f9f9f9;
            border-radius: 8px;
            border: 1px solid #e1e1e1;
        }

        .price-details h3 {
            text-align: center;
            color: #555;
            font-size: 1.2em;
        }

        .price-details p {
            text-align: center;
            font-size: 1em;
            color: #333;
            margin: 8px 0;
        }

        .extra-details h3 {
            color: #444;
            font-size: 1.2em;
            margin-bottom: 10px;
        }

        .form-group p {
            font-size: 0.9em;
            color: #555;
            margin-top: 5px;
        }

        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            h2 {
                font-size: 1.5em;
            }

            input, select, button {
                font-size: 0.9em;
                padding: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Book Flight</h2>
        <form id="flightForm" action=" FlightBookingServlet" method="post">
            <div class="form-group">
                <label for="from">From:</label>
                <select id="from" name="from" required>
                    <option value="Mumbai" <%= "Mumbai".equals(request.getParameter("from")) ? "selected" : ""%>>Mumbai</option>
                    <option value="Delhi" <%= "Delhi".equals(request.getParameter("from")) ? "selected" : ""%>>Delhi</option>
                    <option value="Bangalore" <%= "Bangalore".equals(request.getParameter("from")) ? "selected" : ""%>>Bangalore</option>
                    <option value="Kolkata" <%= "Kolkata".equals(request.getParameter("from")) ? "selected" : ""%>>Kolkata</option>
                    <option value="Chennai" <%= "Chennai".equals(request.getParameter("from")) ? "selected" : ""%>>Chennai</option>
                    <option value="Pune" <%= "Pune".equals(request.getParameter("from")) ? "selected" : ""%>>Pune</option>
                    <option value="Goa" <%= "Goa".equals(request.getParameter("from")) ? "selected" : ""%>>Goa</option>
                    <option value="Hyderabad" <%= "Hyderabad".equals(request.getParameter("from")) ? "selected" : ""%>>Hyderabad</option>
                </select>
            </div>
            <div class="form-group">
                <label for="to">To:</label>
                <select id="to" name="to" required>
                    <option value="Mumbai" <%= "Mumbai".equals(request.getParameter("to")) ? "selected" : ""%>>Mumbai</option>
                    <option value="Delhi" <%= "Delhi".equals(request.getParameter("to")) ? "selected" : ""%>>Delhi</option>
                    <option value="Bangalore" <%= "Bangalore".equals(request.getParameter("to")) ? "selected" : ""%>>Bangalore</option>
                    <option value="Kolkata" <%= "Kolkata".equals(request.getParameter("to")) ? "selected" : ""%>>Kolkata</option>
                    <option value="Chennai" <%= "Chennai".equals(request.getParameter("to")) ? "selected" : ""%>>Chennai</option>
                    <option value="Pune" <%= "Pune".equals(request.getParameter("to")) ? "selected" : ""%>>Pune</option>
                    <option value="Goa" <%= "Goa".equals(request.getParameter("to")) ? "selected" : ""%>>Goa</option>
                    <option value="Hyderabad" <%= "Hyderabad".equals(request.getParameter("to")) ? "selected" : ""%>>Hyderabad</option>
                </select>
            </div>
            <div class="form-group">
                <input type="date" id="travelDate" name="travelDate" value="<%= request.getParameter("travelDate") != null ? request.getParameter("travelDate") : ""%>" required>
            </div>
            <div class="form-group">
                <label for="class">Class:</label>
                <select id="class" name="class" required>
                    <option value="Economy" <%= "Economy".equals(request.getParameter("class")) ? "selected" : ""%>>Economy</option>
                    <option value="Business" <%= "Business".equals(request.getParameter("class")) ? "selected" : ""%>>Business</option>
                </select>
            </div>
            <div class="form-group">
                <label for="passengerCount">Passengers:</label>
                <input type="number" id="passengerCount" name="passengerCount" value="<%= request.getParameter("passengerCount") != null ? request.getParameter("passengerCount") : ""%>" min="1" max="6" required>
            </div>
            <div class="form-group">
                <button type="submit">Fetch Flights</button>
            </div>
        </form>

        <%
            String flightSearchStatus = (String) request.getAttribute("flightSearchStatus");
            String flightNumber = (String) request.getAttribute("flightNumber");
            String airline = (String) request.getAttribute("airline");
            String departureTime = (String) request.getAttribute("departureTime");
            Integer totalPrice = (Integer) request.getAttribute("totalPrice");
            Integer passengerCount = (Integer) request.getAttribute("passengerCount");
        %>

        <% if ("noFlights".equals(flightSearchStatus)) { %>
        <div class="extra-details">
            <h3 style="color: red;">No flights found for the selected route!</h3>
        </div>
        <% } else if (flightNumber != null && airline != null && departureTime != null) {%>
        <div class="extra-details">
            <h3>Flight Details</h3>
            <p><strong>Flight Number:</strong> <%= flightNumber%></p>
            <p><strong>Airline:</strong> <%= airline%></p>
            <p><strong>Departure Time:</strong> <%= departureTime%></p>
        </div>
        <div class="extra-details">
            <h3>Passenger Details</h3>
            <form id="passengerForm" action="PassengerDetailsServlet" method="post">
                <input type="hidden" name="flightNumber" value="<%= flightNumber%>">
                <input type="hidden" name="airline" value="<%= airline%>">
                <input type="hidden" name="travelDate" value="<%= request.getParameter("travelDate")%>">
                <input type="hidden" name="from" value="<%= request.getParameter("from")%>">
                <input type="hidden" name="to" value="<%= request.getParameter("to")%>">
                <input type="hidden" name="passengerCount" value="<%= passengerCount != null ? passengerCount : 1%>">

                <% for (int i = 1; i <= (passengerCount != null ? passengerCount : 1); i++) {%>
                <h4>Passenger <%= i%> Details</h4>
                <label for="name<%= i%>">Name:</label>
                <input type="text" id="name<%= i%>" name="name<%= i%>" required>

                <label for="email<%= i%>">Email:</label>
                <input type="email" id="email<%= i%>" name="email<%= i%>" required>

                <label for="aadhar<%= i%>">Aadhaar:</label>
                <input type="text" id="aadhar<%= i%>" name="aadhar<%= i%>" required>

                <label for="dob<%= i%>">Date of Birth:</label>
                <input type="date" id="dob<%= i%>" name="dob<%= i%>" required>

                <label for="gender<%= i%>">Gender:</label>
                <select id="gender<%= i%>" name="gender<%= i%>" required>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                </select>

                <label for="mobile<%= i%>">Mobile:</label>
                <input type="text" id="mobile<%= i%>" name="mobile<%= i%>" required>
                <% }%>

                <div class="form-group">
                    <button type="submit">Store Passenger Details</button>
                </div>
            </form>
        </div>

        <div class="price-details">
            <h3>Total Price</h3>
            <p><strong>Total Price: </strong>₹ <%= totalPrice%></p>
        </div>

        <div class="form-group">
            <button id="checkoutButton">Proceed to Payment</button>
        </div>

        <script>
            var stripe = Stripe('pk_test_51QSJ9GDQbW2COmJoV6ZuLpjzMTMJzh8xiI3v4bwnjB5N3a4d2nEB47ph50eA9GClKb8sKwslWyNIGDPu05Eirko900mw24wmpl'); // Public key

            checkoutButton.addEventListener("click", function () {
                var params = new URLSearchParams();
                params.append("totalPrice", <%= totalPrice%>); // Ensure this is correctly set

                // Get the email from the first passenger's email input
                var emailInput = document.querySelector('input[id^="email"]');
                if (emailInput) {
                    params.append("email", emailInput.value);
                } else {
                    alert("Email input not found.");
                    return;
                }

                fetch("PaymentServlet", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: params.toString()
                })
                .then(function (response) {
                    console.log("Response status:", response.status); // Log the response status
                    return response.text().then(function (text) {
                        console.log("Response text:", text); // Log the raw response text
                        try {
                            const data = JSON.parse(text); // Try to parse the text as JSON
                            if (data.id) {
                                return stripe.redirectToCheckout({sessionId: data.id});
                            } else {
                                alert(data.error); // Show error message from server
                            }
                        } catch (e) {
                            console.error("Failed to parse JSON:", e);
                            alert("An error occurred while processing the payment.");
                        }
                    });
                })
                .catch(function (error) {
                    console.error("Error:", error); // Log any errors
                });
            });

            // Validation for travel date and date of birth
            document.getElementById("flightForm").addEventListener("submit", function (event) {
                var travelDate = new Date(document.getElementById("travelDate").value);
                var today = new Date();
                today.setHours(0, 0, 0, 0); // Set time to midnight for comparison

                if (travelDate <= today) {
                    alert("Travel date must be after today.");
                    event.preventDefault(); // Prevent form submission
                    return;
                }

                var dobInputs = document.querySelectorAll('input[id^="dob"]');
                for (var i = 0; i < dobInputs.length; i++) {
                    var dob = new Date(dobInputs[i].value);
                    if (dob >= today) {
                        alert("Date of birth must be before today for passenger " + (i + 1) + ".");
                        event.preventDefault(); // Prevent form submission
                        return;
                    }
                }
            });
        </script>

        <% } %>
    </div>
</body>
</html>
