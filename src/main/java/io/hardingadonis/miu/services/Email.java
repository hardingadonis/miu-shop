package io.hardingadonis.miu.services;

import io.hardingadonis.miu.model.*;
import javax.servlet.http.*;

public interface Email {

    public void sendWelcomeEmail(User user);
    
    public void sendVerifyEmail(User user, String code, HttpServletRequest request);
}
