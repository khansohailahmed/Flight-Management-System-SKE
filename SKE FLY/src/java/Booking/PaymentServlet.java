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
import java.util.Random;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Stripe.apiKey = "sk_test_51QSJ9GDQbW2COmJoP81KY4vQ6ijC8eQ0yWwJdEHEUe0hVbNL5zuHetRvnUUbA9qPIjOeOrOfYFPMmaN8VRXfD6xU00cFiErKnT";

        String totalPriceStr = request.getParameter("totalPrice");
        if (totalPriceStr == null || totalPriceStr.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Error: totalPrice is missing or invalid.\"}");
            return;
        }

        try {
            int totalPrice = Integer.parseInt(totalPriceStr) * 100;

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

            // Store PNR in the session
            request.getSession().setAttribute("pnr", pnr);

            response.setContentType("application/json");
            response.getWriter().write("{\"id\":\"" + session.getId() + "\", \"pnr\":\"" + pnr + "\"}");

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Invalid totalPrice format.\"}");
        } catch (StripeException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Error: " + e.getMessage() + "\"}");
        }
    }
}
