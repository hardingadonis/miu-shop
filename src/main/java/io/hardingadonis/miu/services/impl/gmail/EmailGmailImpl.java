package io.hardingadonis.miu.services.impl.gmail;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.services.*;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.*;
import java.util.*;
import javax.servlet.http.*;

public class EmailGmailImpl implements Email {

    private String email;
    private String password;
    private Properties props;

    public EmailGmailImpl() {
        try (InputStream input = EmailGmailImpl.class.getClassLoader().getResourceAsStream("config.gmail.properties")) {
            Properties prop = new Properties();

            if (input == null) {
                System.err.println("Please check config.gmail.properties file!");
            } else {
                prop.load(input);

                this.email = prop.getProperty("config.email.email");
                this.password = prop.getProperty("config.email.password");
            }

        } catch (IOException ex) {
            System.err.println(ex.getMessage());
        }

        this.props = new Properties();
        this.props.put("mail.smtp.host", "smtp.gmail.com");
        this.props.put("mail.smtp.port", "587");
        this.props.put("mail.smtp.auth", "true");
        this.props.put("mail.smtp.starttls.enable", "true");
    }

    @Override
    public void sendWelcomeEmail(User user) {
        Session session = Session.getInstance(this.props, this.getAuthenticator());

        try {
            MimeMessage message = new MimeMessage(session);

            message.setFrom(new InternetAddress(this.email));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(user.getEmail()));
            message.setSubject("Chào mừng đến với Miu Shop!!!", "UTF-8");

            String msgStr = String.format("<html><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><style>body{font-family:Arial,sans-serif;background-color:#f5f5f5;text-align:center;padding:20px}.container{max-width:600px;margin:0 auto;background-color:#fff;padding:30px;border-radius:8px;box-shadow:0 0 20px rgba(0,0,0,.1);text-align:justify}h1{color:#333;font-size:24px;margin-bottom:20px}p{color:#666;text-align:justify;line-height:1.6;margin-bottom:15px}.footer{margin-top:20px;color:#999}.footer a{color:#4caf50;text-decoration:none}</style></head><body><div class=\"container\"><h1>Chào mừng đến với Miu Shop, %s!</h1><p>Miu Shop thực sự hạnh phúc khi chào đón quý khách tới cửa hàng. Chúng tôi trân trọng sự lựa chọn của quý khách khi tạo tài khoản tại Miu Shop. Chúng tôi tin rằng quý khách sẽ tìm thấy những sản phẩm phù hợp và độc đáo tại cửa hàng của chúng tôi.</p><p>Nếu quý khách có bất kỳ câu hỏi hoặc cần hỗ trợ, đừng ngần ngại liên hệ với chúng tôi. Xin chân thành cảm ơn và mong rằng quý khách sẽ có những khoảnh khắc thú vị khi khám phá sản phẩm của Miu Shop.</p></div></body></html>", user.getFullName());

            message.setContent(msgStr, "text/html; charset=UTF-8");

            Transport.send(message);
        } catch (MessagingException ex) {
            System.err.println(ex.getMessage());
        }
    }

    @Override
    public void sendVerifyEmail(User user, String code, HttpServletRequest request) {
        Session session = Session.getInstance(this.props, this.getAuthenticator());

        try {
            MimeMessage message = new MimeMessage(session);

            message.setFrom(new InternetAddress(this.email));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(user.getEmail()));
            message.setSubject("Miu Shop, xác thực tài khoản!", "UTF-8");

            String verifyLink = Server.getServerLink(request) + "verify?email=" + user.getEmail() + "&code=" + code;

            String msgStr = String.format("<html lang=\"vi\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><style>body{font-family:Arial,sans-serif;background-color:#f5f5f5;text-align:center;padding:20px}.container{max-width:600px;margin:0 auto;background-color:#fff;padding:30px;border-radius:8px;box-shadow:0 0 20px rgba(0,0,0,.1);text-align:justify;align-items:center}h1{color:#333;font-size:24px;margin-bottom:20px}p{color:#666;text-align:justify;line-height:1.6;margin-bottom:15px}.button{display:inline-block;padding:10px 20px;font-size:16px;text-align:center;text-decoration:none;color:#fff;background-color:#4caf50;border-radius:5px}</style></head><body><div class=\"container\"><h1>Miu Shop, xác thực tài khoản!</h1><p>Cảm ơn %s đã đăng ký tài khoản tại Miu Shop. Để hoàn tất quá trình đăng ký, vui lòng xác thực tài khoản bằng cách nhấn vào nút bên dưới:</p><a href=\"%s\" class=\"button\" target=\"_blank\">Xác thực tài khoản</a></div></body></html>", user.getFullName(), verifyLink);

            message.setContent(msgStr, "text/html; charset=UTF-8");

            Transport.send(message);

        } catch (MessagingException ex) {
            System.err.println(ex.getMessage());
        }
    }

    @Override
    public void sendForgotPasswordEmail(User user, String code, HttpServletRequest request) {
        Session session = Session.getInstance(this.props, this.getAuthenticator());

        try {
            MimeMessage message = new MimeMessage(session);

            message.setFrom(new InternetAddress(this.email));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(user.getEmail()));
            message.setSubject("Miu Shop, quên mật khẩu!", "UTF-8");

            String forgotPasswordLink = Server.getServerLink(request) + "forgot-change-password?email=" + user.getEmail() + "&code=" + code;

            String msgStr = String.format("<html lang=\"vi\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><style>body{font-family:Arial,sans-serif;background-color:#f5f5f5;text-align:center;padding:20px}.container{max-width:600px;margin:0 auto;background-color:#fff;padding:30px;border-radius:8px;box-shadow:0 0 20px rgba(0,0,0,.1);text-align:justify;align-items:center}h1{color:#333;font-size:24px;margin-bottom:20px}p{color:#666;text-align:justify;line-height:1.6;margin-bottom:15px}.button{display:inline-block;padding:10px 20px;font-size:16px;text-align:center;text-decoration:none;color:#fff;background-color:#4caf50;border-radius:5px}</style></head><body><div class=\"container\"><h1>Miu Shop, Quên mật khẩu!</h1><p>Chào %s. Để tạo mật khẩu mới, vui lòng truy cập vào liên kết bên dưới:</p><a href=\"%s\" class=\"button\" target=\"_blank\">Quên mật khẩu</a></div></body></html>", user.getFullName(), forgotPasswordLink);

            message.setContent(msgStr, "text/html; charset=UTF-8");

            Transport.send(message);
        } catch (MessagingException ex) {
            System.err.println(ex.getMessage());
        }
    }

    private Authenticator getAuthenticator() {
        return new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(email, password);
            }
        };
    }
}
