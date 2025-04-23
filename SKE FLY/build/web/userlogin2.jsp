<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login Page</title>
    <style>
       body {
            font-family: Arial, sans-serif;
            background-color: #d9f7d9; /* Light green background */
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login-form {
            background-color: #fff;
            padding: 40px;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .buttons-container {
            display: flex;
            justify-content: space-between;
        }
        button {
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .login-btn {
            background-color: #4CAF50;
            color: white;
            width: 50%; /* Adjust the width of the login button */
        }
        .login-btn:hover {
            background-color: #45a049;
        }
        .register-btn {
            background-color: #4CAF50; /* Same color as login button */
            color: white;
            width: 200%; /* Adjust the width of the register button */
        }
        .register-btn:hover {
            background-color: #45a049; /* Same hover effect as login button */
        }
    </style>
</head>
<body>
    <div class="login-form">
        <h2>Login</h2>
        <form action="Userlogin2Servlet" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <div class="buttons-container">
                <a href="Register.jsp"><button type="button" class="register-btn">Register</button></a> <!-- Link to Register Page -->
                <button type="submit" class="login-btn">Login</button>
            </div>
        </form>
    </div>
</body>
</html>