package Booking;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/FlightBookingServlet")
public class FlightBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    try {
        String from = request.getParameter("from");
        String to = request.getParameter("to");
        String classType = request.getParameter("class");
        String passengerCountStr = request.getParameter("passengerCount");

        // Validate input parameters
        if (from == null || from.isEmpty() || to == null || to.isEmpty() || classType == null || classType.isEmpty() || passengerCountStr == null || passengerCountStr.isEmpty()) {
            response.getWriter().write("Error: Missing required parameters.");
            return;
        }

        int passengerCount = Integer.parseInt(passengerCountStr);

        // Database connection details
        String jdbcUrl = "jdbc:mysql://localhost:3306/User_Login";
        String dbUser = "root";
        String dbPassword = "Sohail0622";

        try (Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
            String sql = "SELECT flight_number, airline, departure_time, eco_price, bus_price " +
                         "FROM flights WHERE departure_airport = ? AND arrival_airport = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, from);
            stmt.setString(2, to);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String flightNumber = rs.getString("flight_number");
                String airline = rs.getString("airline");
                String departureTime = rs.getString("departure_time");
                int pricePerPerson = "Economy".equals(classType) ? rs.getInt("eco_price") : rs.getInt("bus_price");
                int totalPrice = pricePerPerson * passengerCount;

                // Set attributes for JSP
                request.setAttribute("flightNumber", flightNumber);
                request.setAttribute("airline", airline);
                request.setAttribute("departureTime", departureTime);
                request.setAttribute("pricePerPerson", pricePerPerson);
                request.setAttribute("totalPrice", totalPrice);
                request.setAttribute("passengerCount", passengerCount);
            } else {
                request.setAttribute("flightSearchStatus", "noFlights");
            }

            // Forward to JSP
            request.getRequestDispatcher("BookFlight.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("Database error: " + e.getMessage());
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().write("Error: " + e.getMessage());
    }
}
}
