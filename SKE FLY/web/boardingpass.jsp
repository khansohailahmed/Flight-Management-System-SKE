<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Boarding Pass</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            margin-top: 50px;
            text-align: center;
        }
        .container h1 {
            color: #333;
        }
        .boarding-pass {
            margin-top: 20px;
            text-align: left;
        }
        .boarding-pass table {
            width: 100%;
            border-collapse: collapse;
        }
        .boarding-pass th, .boarding-pass td {
            text-align: left;
            padding: 8px;
            border: 1px solid #ddd;
        }
        .boarding-pass th {
            background-color: #f2f2f2;
        }
        .seat-number {
            font-size: 24px;
            color: green;
            font-weight: bold;
            margin-top: 20px;
        }
        .ok-button {
            margin-top: 20px;
            background-color: green;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .ok-button:hover {
            background-color: darkgreen;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Boarding Pass</h1>

        <%
            String pnr = request.getParameter("pnr");
            String seatNumber = "";
            boolean isBoardingPassGenerated = false;

            if (pnr != null && !pnr.isEmpty()) {
                String url = "jdbc:mysql://localhost:3306/User_Login"; // Update with your DB config
                String user = "root"; // Your DB username
                String password = "Sohail0622"; // Your DB password
                Connection conn = null;
                PreparedStatement pstPassenger = null;
                PreparedStatement pstFlight = null;
                PreparedStatement pstCheckBoarding = null;
                PreparedStatement pstInsertBoarding = null;
                ResultSet rsPassenger = null;
                ResultSet rsFlight = null;
                ResultSet rsBoarding = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, password);

                    // Check if boarding pass already exists
                    String checkBoardingQuery = "SELECT * FROM boarding_pass WHERE pnr = ?";
                    pstCheckBoarding = conn.prepareStatement(checkBoardingQuery);
                    pstCheckBoarding.setString(1, pnr);
                    rsBoarding = pstCheckBoarding.executeQuery();

                    if (rsBoarding.next()) {
                        out.println("<p style='color: red;'>Boarding pass has already been generated for this PNR: " + pnr + "</p>");
                    } else {
                        // Fetch passenger details
                        String passengerQuery = "SELECT * FROM passenger_details2 WHERE pnr = ?";
                        pstPassenger = conn.prepareStatement(passengerQuery);
                        pstPassenger.setString(1, pnr);
                        rsPassenger = pstPassenger.executeQuery();

                        if (rsPassenger.next()) {
                            String name = rsPassenger.getString("name");
                            String flightNumber = rsPassenger.getString("flight_number");
                            String airline = rsPassenger.getString("airline");
                            String fromLocation = rsPassenger.getString("from_location");
                            String toLocation = rsPassenger.getString("to_location");

                            // Fetch flight details
                            String flightQuery = "SELECT * FROM flights WHERE flight_number = ?";
                            pstFlight = conn.prepareStatement(flightQuery);
                            pstFlight.setString(1, flightNumber);
                            rsFlight = pstFlight.executeQuery();

                            if (rsFlight.next()) {
                                String departureTime = rsFlight.getString("departure_time");
                                String arrivalTime = rsFlight.getString("arrival_time");
                                int availableSeats = rsFlight.getInt("available_seats");
                                seatNumber = "A" + (150 - availableSeats + 1); // Generate seat number dynamically

                                // Display boarding pass details
                                out.println("<div class='boarding-pass'>");
                                out.println("<h2>Flight Details</h2>");
                                out.println("<table>");
                                out.println("<tr><th>PNR</th><td>" + pnr + "</td></tr>");
                                out.println("<tr><th>Passenger Name</th><td>" + name + "</td></tr>");
                                out.println("<tr><th>Flight Number</th><td>" + flightNumber + "</td></tr>");
                                out.println("<tr><th>Airline</th><td>" + airline + "</td></tr>");
                                out.println("<tr><th>From</th><td>" + fromLocation + "</td></tr>");
                                out.println("<tr><th>To</th><td>" + toLocation + "</td></tr>");
                                out.println("<tr><th>Departure Time</th><td>" + departureTime + "</td></tr>");
                                out.println("<tr><th>Arrival Time</th><td>" + arrivalTime + "</td></tr>");
                                out.println("<tr><th>Seat Number</th><td>" + seatNumber + "</td></tr>");
                                out.println("</table>");
                                out.println("</div>");

                                // Update available seats in the database
                                String updateSeatsQuery = "UPDATE flights SET available_seats = available_seats - 1 WHERE flight_number = ?";
                                PreparedStatement pstUpdateSeats = conn.prepareStatement(updateSeatsQuery);
                                pstUpdateSeats.setString(1, flightNumber);
                                pstUpdateSeats.executeUpdate();

                                // Insert boarding pass record into the database
                                String insertQuery = "INSERT INTO boarding_pass (pnr, seat_number) VALUES (?, ?)";
                                pstInsertBoarding = conn.prepareStatement(insertQuery);
                                pstInsertBoarding.setString(1, pnr);
                                pstInsertBoarding.setString(2, seatNumber);
                                pstInsertBoarding.executeUpdate();

                                isBoardingPassGenerated = true;
                            } else {
                                out.println("<p style='color: red;'>Flight details not found for flight number: " + flightNumber + "</p>");
                            }
                        } else {
                            out.println("<p style='color: red;'>No passenger found with PNR: " + pnr + "</p>");
                        }
                    }
                } catch (Exception e) {
                    out.println("<p style='color: red;'>An error occurred: " + e.getMessage() + "</p>");
                } finally {
                    if (rsPassenger != null) rsPassenger.close();
                    if (pstPassenger != null) pstPassenger.close();
                    if (rsFlight != null) rsFlight.close();
                    if (pstFlight != null) pstFlight.close();
                    if (conn != null) conn.close();
                }
            } else {
                out.println("<p style='color: red;'>Invalid PNR number.</p>");
            }
        %>

        <%
            if (isBoardingPassGenerated) {
        %>
        <form action="storeBoardingPass.jsp" method="post">
            <input type="hidden" name="pnr" value="<%= pnr %>">
            <input type="hidden" name="seatNumber" value="<%= seatNumber %>">
            <button type="submit" class="ok-button">OK</button>
        </form>
        <% } %>
    </div>
</body>
</html>
