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
            String name = request.getParameter("name");
            String aadhar = request.getParameter("aadhar");
            String dob = request.getParameter("dob");
            String gender = request.getParameter("gender");
            String mobile = request.getParameter("mobile");

            if (flightNumber == null || flightNumber.isEmpty() ||
                airline == null || airline.isEmpty() ||
                travelDate == null || travelDate.isEmpty() ||
                from == null || from.isEmpty() ||
                to == null || to.isEmpty() ||
                passengerCountStr == null || passengerCountStr.isEmpty() ||
                name == null || name.isEmpty() ||
                aadhar == null || aadhar.isEmpty() ||
                dob == null || dob.isEmpty() ||
                gender == null || gender.isEmpty() ||
                mobile == null || mobile.isEmpty()) {
                response.getWriter().write("Error: All fields are required.");
                return;
            }

            int passengerCount = Integer.parseInt(passengerCountStr);

            // Database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/User_Login", "root", "Sohail0622");

            // Insert query
            String query = "INSERT INTO passenger_details (flight_number, airline, travel_date, from_location, to_location, passenger_count, name, aadhar, dob, gender, mobile) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, flightNumber);
            ps.setString(2, airline);
            ps.setString(3, travelDate);
            ps.setString(4, from);
            ps.setString(5, to);
            ps.setInt(6, passengerCount);
            ps.setString(7, name);
            ps.setString(8, aadhar);
            ps.setString(9, dob);
            ps.setString(10, gender);
            ps.setString(11, mobile);

            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                response.getWriter().write("your details is sucessfully saved go back and continue payment process by clicking on the backword error");
            } else {
                response.getWriter().write("Error: Could not store passenger details.");
            }

            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}
