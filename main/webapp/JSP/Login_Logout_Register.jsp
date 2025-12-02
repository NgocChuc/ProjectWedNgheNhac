<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Login_Logout_Register.css">
</head>
<body>
 <div class="login-container">
        <div class="login-card">
            <div class="login-header">
                <h2>Welcome Back</h2>
                <p>Sign in to your account</p>
            </div>
            
            <form class="login-form" id="loginForm" action="login" method="post">
                <div class="form-group">
                    <div class="input-wrapper <%= request.getAttribute("email") != null && !request.getAttribute("email").toString().isEmpty() ? "has-value" : "" %>">
                        <input type="email" id="email" name="email" placeholder=" " required>
                        <label for="email">Email Address</label>
                        <span class="focus-border"></span>
                    </div>
                    <span class="error-message" id="emailError">
                     	<%= request.getAttribute("emailError") != null ? request.getAttribute("emailError") : "" %>
                    </span>
                </div>

                <div class="form-group">
                    <div class="input-wrapper password-wrapper">
                        <input type="password" id="password" name="password" placeholder=" " required>
                        <label>Password</label>
                        <button type="button" class="password-toggle" id="passwordToggle" aria-label="Toggle password visibility">
                            <span class="eye-icon"></span>
                        </button>
                        <span class="focus-border"></span>
                    </div>
                    <span class="error-message" id="passwordError"></span>
                </div>

                <div class="form-options">
                    <label class="remember-wrapper">
                        <input type="checkbox" id="remember" name="remember">
                        <span class="checkbox-label">
                            <span class="checkmark">
                            	<%= request.getAttribute("passwordError") != null ? request.getAttribute("passwordError") : "" %>
                            </span>
                            Remember me
                        </span>
                    </label>
                    <a href="forgot.jsp" class="forgot-password">Forgot password?</a>
                </div>

                <button type="submit" class="login-btn btn">
                    <span class="btn-text">Sign In</span>
                    <span class="btn-loader"></span>
                </button>
                <p style="color: red; text-align: center; margin-top: 10px;">
                	<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
          	  	</p>
            </form>

            <div class="divider">
                <span>or continue with</span>
            </div>

            <div class="social-login">
                <button type="button" class="social-btn google-btn">
                    <span class="social-icon google-icon"></span>
                    Google
                </button>
                <button type="button" class="social-btn facebook-btn">
                    <span class="social-icon facebook-icon"></span>
                    Facebook
                </button>
            </div>

            <div class="signup-link">
                <p>Don't have an account? <a href="register.jsp">Sign up</a></p>
            </div>

            <div class="success-message" id="successMessage">
                <div class="success-icon">✓</div>
                <h3>Login Successful!</h3>
                <p>Redirecting to your dashboard...</p>
            </div>
        </div>
    </div>
</body>
</html>

<script src="${pageContext.request.contextPath}/JS/password_toggle.js"></script>
