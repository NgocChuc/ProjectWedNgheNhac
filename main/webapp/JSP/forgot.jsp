<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
<title>Forgot Password</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Login_Logout_Register.css">
</head>
<body>
<div class="login-container">
    <div class="login-card">
        <div class="login-header">
            <h2>Forgot Password</h2>
            <p>Enter your email to reset password</p>
        </div>
        <form action="forgot" method="post" class="login-form">
            <div class="form-group">
                <div class="input-wrapper <%= request.getAttribute("email") != null ? "has-value" : "" %>">
                    <input type="email" name="email" value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">
                    <label>Email</label>
                    <span class="focus-border"></span>
                </div>
                <span class="error-message"><%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %></span>
            </div>

            <button type="submit" class="login-btn btn">Send Reset Link</button>

            <p style="color:green;text-align:center;">
                <%= request.getAttribute("success") != null ? request.getAttribute("success") : "" %>
            </p>

            <p style="text-align:center;">Back to <a href="Login_Logout_Register.jsp">Login</a></p>
        </form>
    </div>
</div>
</body>
</html>
