package Booking;

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

@WebServlet("/PNRCheckServlet")
public class PNRCheckServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pnr = request.getParameter("pnr");

        if (pnr == null || pnr.isEmpty()) {
            request.setAttribute("error", "PNR cannot be empty.");
            request.getRequestDispatcher("PNRCheck.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/User_Login", "root", "Sohail0622")) {
            String query = "SELECT * FROM passenger_details2 WHERE pnr = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, pnr);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                // Fetching data from the database
                request.setAttribute("pnr", rs.getString("pnr"));
                request.setAttribute("name", rs.getString("name"));
                request.setAttribute("flightNumber", rs.getString("flight_number"));
                request.setAttribute("airline", rs.getString("airline"));
                request.setAttribute("travelDate", rs.getDate("travel_date"));
                request.setAttribute("fromLocation", rs.getString("from_location"));
                request.setAttribute("toLocation", rs.getString("to_location"));
                request.setAttribute("passengerCount", rs.getInt("passenger_count"));
                request.setAttribute("aadhar", rs.getString("aadhar"));
                request.setAttribute("dob", rs.getDate("dob"));
                request.setAttribute("gender", rs.getString("gender"));
                request.setAttribute("mobile", rs.getString("mobile"));
            } else {
                request.setAttribute("error", "No passenger details found for PNR: " + pnr);
            }
            request.getRequestDispatcher("PNRCheck.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("PNRCheck.jsp").forward(request, response);
        }
    }
}
