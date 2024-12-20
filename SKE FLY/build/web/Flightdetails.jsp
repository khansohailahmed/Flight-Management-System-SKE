<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Flight Details</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f7f7f7;
            }

            header {
                background-color: #28a745; /* Green */
                color: white;
                padding: 15px;
                text-align: center;
                font-size: 24px;
                font-weight: bold;
            }

            table {
                width: 90%;
                margin: 20px auto;
                border-collapse: collapse;
                background-color: white;
            }

            th, td {
                text-align: left;
                padding: 10px;
                border: 1px solid #ddd;
            }

            th {
                background-color: #28a745; /* Green */
                color: white;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            .filter-section {
                text-align: center;
                margin: 20px;
            }

            .filter-section input, .filter-section select {
                padding: 10px;
                margin: 10px;
                font-size: 16px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }

            .filter-section button {
                padding: 10px 20px;
                background-color: #28a745; /* Green */
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .filter-section button:hover {
                background-color: #1e7d34; /* Darker Green */
            }
        </style>
    </head>
    <body>
        <header>Flight Details</header>

        <div class="filter-section">
            <input type="text" id="searchInput" placeholder="Search by Flight Number or Airline">
            <button onclick="filterFlights()">Search</button>
        </div>

        <table id="flightsTable">
            <thead>
                <tr>
                    <th>Flight Number</th>
                    <th>Airline</th>
                    <th>Departure Airport</th>
                    <th>Arrival Airport</th>
                    <th>Departure Time</th>
                    <th>Arrival Time</th>
                    <th>Economy Price</th>
                    <th>Business Price</th>
                    <th>Available Seats</th>
                    <th>Class</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Database connection
                    String url = "jdbc:mysql://localhost:3306/User_Login";
                    String user = "root";
                    String password = "Sohail0622";

                    Connection conn = null;
                    Statement stmt = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(url, user, password);
                        stmt = conn.createStatement();
                        String query = "SELECT * FROM flights";
                        ResultSet rs = stmt.executeQuery(query);

                        while (rs.next()) {
                            String flightNumber = rs.getString("flight_number");
                            String airline = rs.getString("airline");
                            String departureAirport = rs.getString("departure_airport");
                            String arrivalAirport = rs.getString("arrival_airport");
                            String departureTime = rs.getString("departure_time");
                            String arrivalTime = rs.getString("arrival_time");
                            double ecoPrice = rs.getDouble("eco_price");
                            double busPrice = rs.getDouble("bus_price");
                            int availableSeats = rs.getInt("available_seats");
                            String flightClass = rs.getString("class");
                %>
                <tr>
                    <td><%= flightNumber%></td>
                    <td><%= airline%></td>
                    <td><%= departureAirport%></td>
                    <td><%= arrivalAirport%></td>
                    <td><%= departureTime%></td>
                    <td><%= arrivalTime%></td>
                    <td>₹<%= ecoPrice%></td>
                    <td>₹<%= busPrice%></td>
                    <td><%= availableSeats%></td>
                    <td><%= flightClass%></td>
                </tr>
                <%
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </tbody>
        </table>

        <script>
            function filterFlights() {
                const input = document.getElementById('searchInput').value.toLowerCase();
                const table = document.getElementById('flightsTable');
                const rows = table.getElementsByTagName('tr');

                for (let i = 1; i < rows.length; i++) {
                    const cells = rows[i].getElementsByTagName('td');
                    let match = false;

                    for (let j = 0; j < cells.length; j++) {
                        if (cells[j].innerText.toLowerCase().includes(input)) {
                            match = true;
                            break;
                        }
                    }

                    rows[i].style.display = match ? '' : 'none';
                }
            }
        </script>
    </body>
</html>
