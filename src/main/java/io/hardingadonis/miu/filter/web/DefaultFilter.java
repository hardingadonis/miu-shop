package io.hardingadonis.miu.filter.web;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class DefaultFilter implements Filter {

    public DefaultFilter() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String url = req.getServletPath();

        if (url.equals("/") || url.contains(".jsp")) {
            res.sendRedirect(req.getContextPath() + "/home");
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
    }

    @Override
    public void init(FilterConfig filterConfig) {
    }
}
