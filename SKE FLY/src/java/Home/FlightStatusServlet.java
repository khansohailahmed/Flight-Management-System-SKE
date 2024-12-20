package Home;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/FlightStatusServlet")
public class FlightStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String flightId = request.getParameter("flightId");
        if (flightId == null || flightId.trim().isEmpty()) {
            request.setAttribute("error", "Flight ID cannot be empty.");
            request.getRequestDispatcher("FlightStatus.jsp").forward(request, response);
            return;
        }

        String url = "jdbc:mysql://localhost:3306/User_Login"; // Update with your database name
        String user = "root";
        String password = "Sohail0622";

        try (Connection con = DriverManager.getConnection(url, user, password);
             PreparedStatement ps = con.prepareStatement("SELECT * FROM flights WHERE flight_number = ?")) {
             
            ps.setString(1, flightId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("flightId", rs.getString("flight_id"));
                request.setAttribute("flightNumber", rs.getString("flight_number"));
                request.setAttribute("airline", rs.getString("airline"));
                request.setAttribute("departureAirport", rs.getString("departure_airport"));
                request.setAttribute("arrivalAirport", rs.getString("arrival_airport"));
                request.setAttribute("departureTime", rs.getString("departure_time"));
                request.setAttribute("arrivalTime", rs.getString("arrival_time"));
                request.setAttribute("ecoPrice", rs.getString("eco_price"));
                request.setAttribute("busPrice", rs.getString("bus_price"));
                request.setAttribute("availableSeats", rs.getString("available_seats"));
                request.setAttribute("class", rs.getString("class"));
            } else {
                request.setAttribute("error", "No details found for the entered Flight ID.");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Error while fetching data: " + e.getMessage());
        }

        request.getRequestDispatcher("FlightStatus.jsp").forward(request, response);
    }
}