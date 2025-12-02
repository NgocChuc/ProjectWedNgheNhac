<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
<title>Register</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Login_Logout_Register.css">
</head>
<body>
<div class="login-container">
    <div class="login-card">
        <div class="login-header">
            <h2>Create Account</h2>
            <p>Sign up to your account</p>
        </div>
        <form action="register" method="post" class="login-form">
            <div class="form-group">
                <div class="input-wrapper <%= request.getAttribute("username") != null ? "has-value" : "" %>">
                    <input type="text" id="username" name="username" placeholder=" " required
						value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>">
                    <label for="username">Username</label>
                    <span class="focus-border"></span>
                </div>
                <span class="error-message"><%= request.getAttribute("usernameError") != null ? request.getAttribute("usernameError") : "" %></span>
            </div>

            <div class="form-group">
                <div class="input-wrapper <%= request.getAttribute("email") != null ? "has-value" : "" %>">
                    <input type="email" id="email" name="email" placeholder=" " required
                    	value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">
                    <label for="email">Email</label>
                    <span class="focus-border"></span>
                </div>
                <span class="error-message"><%= request.getAttribute("emailError") != null ? request.getAttribute("emailError") : "" %></span>
            </div>

            <div class="form-group">
                <div class="input-wrapper">
                    <input type="password" id="password" name="password" placeholder=" " required>
                    <label for="password">Password</label>
                    <span class="focus-border"></span>
                </div>
                <span class="error-message"><%= request.getAttribute("passwordError") != null ? request.getAttribute("passwordError") : "" %></span>
            </div>

            <div class="form-group">
                <div class="input-wrapper">
                    <input type="password" id="confirm" name="confirm" placeholder=" " required>
                    <label for="confirm">Confirm Password</label>
                    <span class="focus-border"></span>
                </div>
                <span class="error-message"><%= request.getAttribute("confirmError") != null ? request.getAttribute("confirmError") : "" %></span>
            </div>

            <button type="submit" class="login-btn btn">Sign Up</button>

            <p style="color:green;text-align:center;">
                <%= request.getAttribute("success") != null ? request.getAttribute("success") : "" %>
            </p>

            <p style="text-align:center;">Already have an account? <a href="Login_Logout_Register.jsp">Login</a></p>
        </form>
    </div>
</div>
</body>
</html>
