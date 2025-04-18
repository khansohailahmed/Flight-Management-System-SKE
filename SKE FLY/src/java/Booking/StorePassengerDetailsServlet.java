package Booking;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/StorePassengerDetailsServlet")
public class StorePassengerDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve passenger details from session
        String name = (String) session.getAttribute("name");
        String email = (String) session.getAttribute("email"); // Retrieve email
        String flightNumber = (String) session.getAttribute("flight_number");
        String airline = (String) session.getAttribute("airline");
        java.sql.Date travelDate = (java.sql.Date) session.getAttribute("travel_date");
        String fromLocation = (String) session.getAttribute("from_location");
        String toLocation = (String) session.getAttribute("to_location");
        int passengerCount = (Integer) session.getAttribute("passenger_count");
        String aadhar = (String) session.getAttribute("aadhar");
        java.sql.Date dob = (java.sql.Date) session.getAttribute("dob");
        String gender = (String) session.getAttribute("gender");
        String mobile = (String) session.getAttribute("mobile");

        // Retrieve the PNR from session
        Integer pnr = (Integer) session.getAttribute("pnr");
        String pnrStr = pnr != null ? String.valueOf(pnr) : "N/A"; // Ensure PNR is stored as String

        // Database connection and insertion logic
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/User_Login", "root", "Sohail0622")) {

            // Insert passenger details into the database
            String query = "INSERT INTO passenger_details2 (pnr, name, email, flight_number, airline, travel_date, from_location, to_location, passenger_count, aadhar, dob, gender, mobile) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, pnrStr); // Set PNR as String
            pstmt.setString(2, name);
            pstmt.setString(3, email != null ? email : "N/A"); // Set email, default to "N/A" if null
            pstmt.setString(4, flightNumber);
            pstmt.setString(5, airline);
            pstmt.setDate(6, travelDate);
            pstmt.setString(7, fromLocation);
            pstmt.setString(8, toLocation);
            pstmt.setInt(9, passengerCount);
            pstmt.setString(10, aadhar);
            pstmt.setDate(11, dob);
            pstmt.setString(12, gender);
            pstmt.setString(13, mobile);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("index.html"); // Redirect to a confirmation page
            } else {
                response.getWriter().println("<p>Error saving details</p>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
}
