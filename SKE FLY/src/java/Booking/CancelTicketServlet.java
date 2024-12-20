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

@WebServlet("/CancelTicketServlet")
public class CancelTicketServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String message = null;

        if ("fetch".equals(action)) {
            String pnr = request.getParameter("pnr");
            if (pnr != null && !pnr.trim().isEmpty()) {
                // Database connection details
                String dbURL = "jdbc:mysql://localhost:3306/User_Login";
                String dbUser = "root";
                String dbPassword = "Sohail0622";

                try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword); PreparedStatement stmt = conn.prepareStatement("SELECT * FROM passenger_details2 WHERE pnr = ?")) {

                    stmt.setString(1, pnr);
                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        request.setAttribute("pnr", rs.getString("pnr"));
                        request.setAttribute("name", rs.getString("name"));
                        request.setAttribute("flightNumber", rs.getString("flight_number"));
                        request.setAttribute("airline", rs.getString("airline"));
                        request.setAttribute("travelDate", rs.getString("travel_date"));
                        request.setAttribute("fromLocation", rs.getString("from_location"));
                        request.setAttribute("toLocation", rs.getString("to_location"));
                        request.setAttribute("passengerCount", rs.getInt("passenger_count"));
                        request.setAttribute("aadhar", rs.getString("aadhar"));
                        request.setAttribute("dob", rs.getString("dob"));
                        request.setAttribute("gender", rs.getString("gender"));
                        request.setAttribute("mobile", rs.getString("mobile"));
                    } else {
                        message = "No ticket found with PNR " + pnr + ".";
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    message = "An error occurred while fetching the ticket details. Please try again.";
                }
            } else {
                message = "Invalid PNR provided.";
            }
        } else if ("cancel".equals(action)) {
            String pnrToDelete = request.getParameter("pnrToDelete");
            if (pnrToDelete != null && !pnrToDelete.trim().isEmpty()) {
                // Database connection details
                String dbURL = "jdbc:mysql://localhost:3306/User_Login";
                String dbUser = "root";
                String dbPassword = "Sohail0622";

                try (Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword); PreparedStatement stmt = conn.prepareStatement("DELETE FROM passenger_details2 WHERE pnr = ?")) {

                    stmt.setString(1, pnrToDelete);
                    int rowsAffected = stmt.executeUpdate();

                    if (rowsAffected > 0) {
                        message = "Ticket with PNR " + pnrToDelete + " has been successfully canceled. Refund will be processed in 2-3 working days.";
                    } else {
                        message = "No ticket found with PNR " + pnrToDelete + ".";
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    message = "An error occurred while canceling the ticket. Please try again.";
                }
            } else {
                message = "Invalid PNR provided.";
            }
        }

        // Pass the message back to the JSP
        request.setAttribute("error", message);
        request.getRequestDispatcher("CancelTicket.jsp").forward(request, response);
    }
}
