package Filter_Layer;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

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

        // Các URL public
        boolean isPublic = path.startsWith(contextPath + "/login") ||
                           path.startsWith(contextPath + "/register") ||
                           path.contains("/css/") ||
                           path.contains("/js/") ||
                           path.contains("/images/");
        					path.startsWith(contextPath + "/JSP/login.jsp");

        if (loggedIn) {
            // Nếu đã login, truy cập login/register → redirect về home
            if (path.startsWith(contextPath + "/login") || path.startsWith(contextPath + "/register")) {
                response.sendRedirect(contextPath + "/home");
                return;
            }
        } else {
            // Chưa login và truy cập trang private → forward login
            if (!isPublic) {
                request.getRequestDispatcher("/JSP/login.jsp").forward(request, response);
                return;
            }
        }

        // Cho phép truy cập trang public hoặc user đã login
        chain.doFilter(req, res);
    }
}

