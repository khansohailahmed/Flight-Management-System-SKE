<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Check PNR</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #4CAF50;
        }
        form {
            margin-bottom: 20px;
        }
        label, p {
            font-size: 16px;
        }
        input[type="text"], button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            font-size: 14px;
        }
        .details {
            margin-top: 20px;
            font-size: 16px;
            line-height: 1.6;
        }
        .ok-button {
            text-align: center;
        }
        .ok-button button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            cursor: pointer;
        }
        .ok-button button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Check PNR</h1>
        <form method="post" action="PNRCheckServlet">
            <label for="pnr">Enter PNR:</label>
            <input type="text" id="pnr" name="pnr" placeholder="Enter PNR" required>
            <button type="submit">Fetch Details</button>
        </form>

        <div class="error">
            <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
                    out.print(error);
                }
            %>
        </div>

        <div class="details">
            <%
                String pnr = (String) request.getAttribute("pnr");
                if (pnr != null) {
                    out.println("<p><strong>PNR:</strong> " + pnr + "</p>");
                    out.println("<p><strong>Name:</strong> " + request.getAttribute("name") + "</p>");
                    out.println("<p><strong>Flight Number:</strong> " + request.getAttribute("flightNumber") + "</p>");
                    out.println("<p><strong>Airline:</strong> " + request.getAttribute("airline") + "</p>");
                    out.println("<p><strong>Travel Date:</strong> " + request.getAttribute("travelDate") + "</p>");
                    out.println("<p><strong>From:</strong> " + request.getAttribute("fromLocation") + "</p>");
                    out.println("<p><strong>To:</strong> " + request.getAttribute("toLocation") + "</p>");
                    out.println("<p><strong>Passenger Count:</strong> " + request.getAttribute("passengerCount") + "</p>");
                    out.println("<p><strong>Aadhar:</strong> " + request.getAttribute("aadhar") + "</p>");
                    out.println("<p><strong>Date of Birth:</strong> " + request.getAttribute("dob") + "</p>");
                    out.println("<p><strong>Gender:</strong> " + request.getAttribute("gender") + "</p>");
                    out.println("<p><strong>Mobile:</strong> " + request.getAttribute("mobile") + "</p>");
                }
            %>
        </div>

        <div class="ok-button">
            <button onclick="window.location.href = 'index.html'">OK</button>
        </div>
    </div>
</body>
</html>
