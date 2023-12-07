package io.hardingadonis.miu.services;

import javax.servlet.http.*;

public class Server {

    public static String getServerLink(HttpServletRequest request) {
        return request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
    }
}
