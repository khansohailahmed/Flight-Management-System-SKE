<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flight Search</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #4CAF50;
        }
        form {
            margin-bottom: 20px;
        }
        label, p {
            font-size: 16px;
        }
        input[type="text"], button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            font-size: 14px;
        }
        .details {
            margin-top: 20px;
            font-size: 16px;
            line-height: 1.6;
        }
        .ok-button {
            text-align: center;
        }
        .ok-button button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }
        .ok-button button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Search Flight</h1>
        <form method="post" action="FlightStatusServlet">
            <label for="flightId">Enter Flight ID</label>
            <input type="text" id="flightId" name="flightId" placeholder="Enter Flight ID" required>
            <button type="submit">Search Flight</button>
        </form>

        <div class="error">
            <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
                    out.print(error);
                }
            %>
        </div>

        <div class="details">
            <%
                String flightId = (String) request.getAttribute("flightId");
                if (flightId != null) {
                    out.println("<p><strong>Flight ID:</strong> " + flightId + "</p>");
                    out.println("<p><strong>Flight Number:</strong> " + request.getAttribute("flightNumber") + "</p>");
                    out.println("<p><strong>Airline:</strong> " + request.getAttribute("airline") + "</p>");
                    out.println("<p><strong>Departure Airport:</strong> " + request.getAttribute("departureAirport") + "</p>");
                    out.println("<p><strong>Arrival Airport:</strong> " + request.getAttribute("arrivalAirport") + "</p>");
                    out.println("<p><strong>Departure Time:</strong> " + request.getAttribute("departureTime") + "</p>");
                    out.println("<p><strong>Arrival Time:</strong> " + request.getAttribute("arrivalTime") + "</p>");
                    out.println("<p><strong>Economy Price:</strong> RS  " + request.getAttribute("ecoPrice") + "</p>");
                    out.println("<p><strong>Business Price:</strong> RS " + request.getAttribute("busPrice") + "</p>");
                    out.println("<p><strong>Available Seats:</strong> " + request.getAttribute("availableSeats") + "</p>");
                    out.println("<p><strong>Class:</strong> " + request.getAttribute("class") + "</p>");
                }
            %>
        </div>

        <div class="ok -button">
            <button onclick="window.location.href = 'index.html'">OK</button>
        </div>
    </div>
</body>
</html>