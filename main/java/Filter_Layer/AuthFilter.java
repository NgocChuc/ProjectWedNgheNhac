package Filter_Layer;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

@WebFilter("/*")
public class AuthFilter implements Filter {

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String path = request.getRequestURI();

        boolean isLoginPage =
                path.contains("login.jsp") ||
                path.contains("register.jsp") ||
                path.contains("/login") ||
                path.contains("/register") ||
                path.contains("css") ||
                path.contains("js") ||
                path.contains("images");

        HttpSession session = request.getSession(false);

        if (!isLoginPage && (session == null || session.getAttribute("user") == null)) {
            response.sendRedirect("login.jsp");
            return;
        }

        chain.doFilter(req, res);
    }
}
