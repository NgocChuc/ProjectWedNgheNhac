package Filter_Layer;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import Model_Layer.User;

@WebFilter(urlPatterns = {"/admin", "/admin/dashboard-data", "/adminUser", "/adminSongs"})
public class AdminFilter implements Filter {

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        // 1. Kiểm tra Session
        if (session == null || session.getAttribute("user") == null) {
            System.out.println("DEBUG AdminFilter: No session found, redirecting to login.");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        
        // 2. Lấy role và chuẩn hóa lại một lần nữa
        String role = (user.getRole() != null) ? user.getRole().trim().toLowerCase() : "";

        // 3. Log thông tin để kiểm tra trên Console
        System.out.println("--- ADMIN FILTER CHECK ---");
        System.out.println("Request URI: " + request.getRequestURI());
        System.out.println("Current User Role: [" + role + "]");

        // 4. Kiểm tra quyền
        if (!"admin".equals(role)) {
            System.out.println("RESULT: Role is NOT admin. Redirecting to /home");
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        System.out.println("RESULT: Access Granted to Admin!");
        chain.doFilter(req, res);
    }

    public void init(FilterConfig filterConfig) throws ServletException {}
    public void destroy() {}
}
