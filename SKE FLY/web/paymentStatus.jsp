<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Status</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f0f8ff;
        }

        .status-container {
            background: #ffffff;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
            max-width: 450px;
            width: 100%;
            text-align: center;
        }

        .status-container h1 {
            color: #28a745;
            font-size: 32px;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .status-container p {
            font-size: 18px;
            color: #555;
            line-height: 1.6;
        }

        .status-container p.error {
            color: #e74c3c;
            font-weight: 500;
        }

        .status-container p strong {
            color: #333;
            font-weight: 600;
        }

        .status-container button {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 18px;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 20px;
            transition: background-color 0.3s;
        }

        .status-container button:hover {
            background-color: #218838;
        }

        .status-container a {
            color: #28a745;
            text-decoration: none;
            font-size: 16px;
            margin-top: 15px;
            display: inline-block;
        }

        .status-container a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="status-container">
        <h1>Payment Status</h1>
        <%
            String paymentId = (String) request.getAttribute("paymentId");
            String status = (String) request.getAttribute("status");
            String error = (String) request.getAttribute("error");

            if (error != null) {
        %>
            <p class="error"><strong>Error:</strong> <%= error %></p>
        <% } else if (status != null) { %>
            <p><strong>Payment Intent ID:</strong> <%= paymentId %></p>
            <p><strong>Status:</strong> <%= status %></p>
        <% } else { %>
            <p class="error">No status available.</p>
        <% } %>

        <a href="index.html">Go Back to Home</a>
    </div>
</body>
</html>
