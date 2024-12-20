/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Booking;
import com.stripe.Stripe;
import com.stripe.model.PaymentIntent;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/PaymentStatusServlet")
public class PaymentStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set your Stripe secret key (test mode)
        Stripe.apiKey = "sk_test_51QSJ9GDQbW2COmJoP81KY4vQ6ijC8eQ0yWwJdEHEUe0hVbNL5zuHetRvnUUbA9qPIjOeOrOfYFPMmaN8VRXfD6xU00cFiErKnT";

        String paymentId = request.getParameter("paymentId"); // Get Payment ID from form input

        try {
            // Retrieve the PaymentIntent from Stripe
            PaymentIntent paymentIntent = PaymentIntent.retrieve(paymentId);

            // Extract payment status
            String status = paymentIntent.getStatus();

            // Set attributes to forward to the JSP
            request.setAttribute("paymentId", paymentId);
            request.setAttribute("status", status);

            // Forward the response to the JSP for rendering
            request.getRequestDispatcher("paymentStatus.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("paymentStatus.jsp").forward(request, response);
        }
    }
}