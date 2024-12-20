<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Status</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f9;
        }
        .payment-status-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
        }
        .payment-status-container h2 {
            text-align: center;
            color: #333;
        }
        .payment-status-container form input, 
        .payment-status-container form button {
            width: 100%;
            margin: 10px 0;
            padding: 12px;
            font-size: 16px;
            border-radius: 5px;
        }
        form input {
            border: 1px solid #ccc;
        }
        form button {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        form button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="payment-status-container">
        <h2>Check Payment Status</h2>
        <form id="paymentStatusForm" method="POST" action="PaymentStatusServlet">
            <label for="paymentId">Enter Payment Intent ID:</label>
            <input type="text" id="paymentId" name="paymentId" placeholder="Enter Payment Intent ID" required />
            <button type="submit">Check Status</button>
        </form>
    </div>
</body>
</html>
