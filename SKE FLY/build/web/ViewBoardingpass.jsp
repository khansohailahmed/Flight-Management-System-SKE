<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>View Boarding Pass</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 60%;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            margin-top: 50px;
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
        }
        .header h1 {
            color: #333;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        input[type="submit"] {
            background-color: #28a745; /* Green background */
            color: #fff;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #218838; /* Darker green on hover */
        }
        .boarding-pass {
            margin-top: 20px;
            text-align: center;
        }
        .boarding-pass table {
            width: 100%;
            border-collapse: collapse;
        }
        .boarding-pass th, .boarding-pass td {
            text-align: left;
            padding: 8px;
            border: 1px solid #ddd;
        }
        .boarding-pass th {
            background-color: #f2f2f2;
        }
        .ok-button {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .ok-button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>View Boarding Pass</h1>
        </div>

        <!-- Form to enter PNR -->
        <form method="post">
            <div class="form-group">
                <label for="pnr">Enter PNR Number:</label>
                <input type="text" name="pnr" id="pnr" required>
            </div>
            <input type="submit" value="View Boarding Pass">
        </form>

        <%
            String pnr = request.getParameter("pnr");
            if (pnr != null && !pnr.isEmpty()) {
                String url = "jdbc:mysql://localhost:3306/User_Login"; // Update with your DB config
                String user = "root"; // Your DB username
                String password = "Sohail0622"; // Your DB password
                Connection conn = null;
                PreparedStatement pst = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, password);
                    String query = "SELECT * FROM boarding_pass WHERE pnr = ?";
                    pst = conn.prepareStatement(query);
                    pst.setString(1, pnr);
                    rs = pst.executeQuery();

                    if (rs.next()) {
                        String boardingPassPNR = rs.getString("pnr");
                        String seatNumber = rs.getString("seat_number");

                        out.println("<div class='boarding-pass'>");
                        out.println("<h3>Boarding Pass Details</h3>");
                        out.println("<table>");
                        out.println("<tr><th>PNR</th><td>" + boardingPassPNR + "</td></tr>");
                        out.println("<tr><th>Seat Number</th><td>" + seatNumber + "</td></tr>");
                        out.println("</table>");
                        out.println("<form action='index.html' method='get'>"); // Redirect to index.html
                        out.println("<button class='ok-button' type='submit'>OK</button>");
                        out.println("</form>");
                        out.println("</div>");
                    } else {
                        out.println("<p style='color: red;'>No boarding pass found for PNR: " + pnr + "</p>");
                    }
                } catch (Exception e) {
                    out.println("<p style='color: red;'>An error occurred: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) rs.close();
                    if (pst != null) pst.close();
                    if (conn != null) conn.close();
                }
            }
        %>
    </div>
</body>
</html>
