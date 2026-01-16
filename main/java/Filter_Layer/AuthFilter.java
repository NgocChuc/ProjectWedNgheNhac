package Filter_Layer;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import Model_Layer.User;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String path = request.getRequestURI();
        String contextPath = request.getContextPath();

        HttpSession session = request.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("user") != null);

        // Pages that require login
        boolean isRequiredAuth = path.startsWith(contextPath + "/download") ||
                                 path.startsWith(contextPath + "/add-to-playlist") ||
                                 path.startsWith(contextPath + "/profile");

        // Login/Register pages
        boolean isAuthPage = path.startsWith(contextPath + "/login") ||
                             path.startsWith(contextPath + "/register") ||
                             path.contains("login.jsp");

        if (loggedIn) {
            // Already logged in, prevent going back to login/register
            if (isAuthPage) {
                User user = (User) session.getAttribute("user");
                String role = (user.getRole() != null) ? user.getRole().trim().toLowerCase() : "";
                
                if ("admin".equals(role)) {
                    response.sendRedirect(contextPath + "/admin/dashboard-data");
                } else {
                    response.sendRedirect(contextPath + "/home");
                }
                return;
            }
        } else {
            // Not logged in, trying to access protected pages
            if (isRequiredAuth) {
                response.sendRedirect(contextPath + "/login");
                return;
            }
        }

        // Allow all other requests
        chain.doFilter(req, res);
    }
}
