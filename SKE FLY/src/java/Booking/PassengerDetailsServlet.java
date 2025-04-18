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

@WebServlet("/PassengerDetailsServlet")
public class PassengerDetailsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String flightNumber = request.getParameter("flightNumber");
            String airline = request.getParameter("airline");
            String travelDate = request.getParameter("travelDate");
            String from = request.getParameter("from");
            String to = request.getParameter("to");
            String passengerCountStr = request.getParameter("passengerCount");

            if (flightNumber == null || flightNumber.isEmpty() ||
                airline == null || airline.isEmpty() ||
                travelDate == null || travelDate.isEmpty() ||
                from == null || from.isEmpty() ||
                to == null || to.isEmpty() ||
                passengerCountStr == null || passengerCountStr.isEmpty()) {
                response.getWriter().write("Error: All fields are required.");
                return;
            }

            int passengerCount = Integer.parseInt(passengerCountStr);

            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/User_Login", "root", "Sohail0622");

            // Corrected insert query
            String query = "INSERT INTO passenger_details (flight_number, airline, travel_date, from_location, to_location, passenger_count, name, email, aadhar, dob, gender, mobile) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);

            for (int i = 1; i <= passengerCount; i++) {
                String name = request.getParameter("name" + i);
                String email = request.getParameter("email" + i); // Retrieve email
                String aadhar = request.getParameter("aadhar" + i);
                String dob = request.getParameter("dob" + i);
                String gender = request.getParameter("gender" + i);
                String mobile = request.getParameter("mobile" + i);

                // Check for null or empty values
                if (name == null || name.isEmpty() ||
                    email == null || email.isEmpty() || // Check for email
                    aadhar == null || aadhar.isEmpty() ||
                    dob == null || dob.isEmpty() ||
                    gender == null || gender.isEmpty() ||
                    mobile == null || mobile.isEmpty()) {
                    response.getWriter().write("Error: All passenger fields are required.");
                    return;
                }

                // Replace commas and trim
                name = name.replace(",", "_").trim();
                email = email.replace(",", "_").trim(); // Replace commas in email
                aadhar = aadhar.replace(",", "_").trim();
                mobile = mobile.replace(",", "_").trim();

                // Set parameters for the prepared statement
                ps.setString(1, flightNumber);
                ps.setString(2, airline);
                ps.setString(3, travelDate);
                ps.setString(4, from);
                ps.setString(5, to);
                ps.setInt(6, passengerCount);
                ps.setString(7, name);
                ps.setString(8, email); // Set email
                ps.setString(9, aadhar);
                ps.setString(10, dob);
                ps.setString(11, gender);
                ps.setString(12, mobile); // Ensure this line is included

                // Execute the insert for each passenger
                ps.executeUpdate();
            }

            // Send a response to show an alert and go back to the previous page
            response.setContentType("text/html");
            response.getWriter().write("<html><body><script>alert('Passenger details stored successfully!'); window.history.back();</script></body></html>");
            return; // Ensure no further processing occurs

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}
