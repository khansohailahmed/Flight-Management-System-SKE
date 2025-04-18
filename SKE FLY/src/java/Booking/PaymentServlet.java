package Booking;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set Stripe API key
        Stripe.apiKey = "sk_test_51QSJ9GDQbW2COmJoP81KY4vQ6ijC8eQ0yWwJdEHEUe0hVbNL5zuHetRvnUUbA9qPIjOeOrOfYFPMmaN8VRXfD6xU00cFiErKnT";

        // Get total price from request
        String totalPriceStr = request.getParameter("totalPrice");
        String email = request.getParameter("email"); // Get email from request

        if (totalPriceStr == null || totalPriceStr.isEmpty() || email == null || email.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Error: totalPrice or email is missing or invalid.\"}");
            return;
        }

        try {
            int totalPrice = Integer.parseInt(totalPriceStr) * 100; // Convert to cents

            // Create Stripe checkout session
            SessionCreateParams params = SessionCreateParams.builder()
                    .setMode(SessionCreateParams.Mode.PAYMENT)
                    .addLineItem(
                            SessionCreateParams.LineItem.builder()
                                    .setPriceData(
                                            SessionCreateParams.LineItem.PriceData.builder()
                                                    .setCurrency("inr")
                                                    .setUnitAmount((long) totalPrice)
                                                    .setProductData(
                                                            SessionCreateParams.LineItem.PriceData.ProductData.builder()
                                                                    .setName("Flight Booking")
                                                                    .build()
                                                    )
                                                    .build()
                                    )
                                    .setQuantity(1L)
                                    .build()
                    )
                    .setSuccessUrl("http://localhost:8080/SKE_FLY/PNR.jsp")
                    .setCancelUrl("https://example.com/cancel")
                    .build();

            Session session = Session.create(params);

            // Generate a 6-digit PNR
            Random random = new Random();
            int pnr = 100000 + random.nextInt(900000);

            // Store PNR and email in the session
            request.getSession().setAttribute("pnr", pnr);
            request.getSession().setAttribute("email", email);

            // Send email confirmation
            sendEmail(email, pnr);

            // Return response with Stripe session ID and PNR
            response.setContentType("application/json");
            response.getWriter().write("{\"id\":\"" + session.getId() + "\", \"pnr\":\"" + pnr + "\"}");

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Invalid totalPrice format.\"}");
        } catch (StripeException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Error: " + e.getMessage() + "\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Error: " + e.getMessage() + "\"}");
        }
    }

// Function to send email confirmation
    private void sendEmail(String toEmail, int pnr) {
        String fromEmail = "testemailforproject06@gmail.com"; // Replace with your email
        String password = "cxul zgcr yuof ztii"; // Replace with your email password

        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com"); // Gmail SMTP
        properties.put("mail.smtp.port", "587"); // TLS port

        javax.mail.Session mailSession = javax.mail.Session.getInstance(properties, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Your PNR Confirmation");
            message.setText("Dear Customer,\n\nYour flight booking is confirmed.\nYour PNR is: " + pnr + "\n\nThank you!");

            Transport.send(message);
            System.out.println("Email sent successfully!");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
