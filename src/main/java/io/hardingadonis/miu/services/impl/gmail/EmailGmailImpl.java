package io.hardingadonis.miu.services.impl.gmail;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.services.*;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.io.*;
import java.util.*;

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
            Message message = new MimeMessage(session);

            message.setFrom(new InternetAddress(this.email));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(user.getEmail()));
            message.setSubject("Welcome to R7 Shop!!!");

            String msgStr = String.format("<html><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\"><style>body{font-family:Arial,sans-serif;background-color:#f5f5f5;text-align:center;padding:20px}.container{max-width:600px;margin:0 auto;background-color:#fff;padding:30px;border-radius:8px;box-shadow:0 0 20px rgba(0,0,0,.1);text-align:justify}h1{color:#333;font-size:24px;margin-bottom:20px}p{color:#666;text-align:justify;line-height:1.6;margin-bottom:15px}.footer{margin-top:20px;color:#999}.footer a{color:#4caf50;text-decoration:none}</style></head><body><div class=\"container\"><h1>Welcome to R7 Shop, %s!</h1><p>We're thrilled to have you join our community. Thank you for choosing R7 Shop for your shopping needs. Get ready for an amazing experience with our high-quality products and excellent customer service.</p><p>If you have any questions or need assistance, feel free to reach out to our support team. Happy shopping!</p></div></body></html>", user.getFullName());

            message.setContent(msgStr, "text/html; charset=UTF-8");

            Transport.send(message);

            System.out.println("Sent a welcome letter to " + user.getEmail());
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
