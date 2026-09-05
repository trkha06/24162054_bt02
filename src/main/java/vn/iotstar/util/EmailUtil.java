package vn.iotstar.util;

import java.io.IOException;
import java.io.InputStream;
import java.security.SecureRandom;
import java.util.Properties;
import java.util.regex.Pattern;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {

    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
    private static final Pattern EMAIL_PATTERN = Pattern.compile(EMAIL_REGEX);
    private static final Properties FILE_SETTINGS = loadFileSettings();

    private static final String SMTP_HOST = setting("mail.smtp.host", "MAIL_SMTP_HOST", "smtp.gmail.com");
    private static final String SMTP_PORT = setting("mail.smtp.port", "MAIL_SMTP_PORT", "587");
    private static final String SENDER_EMAIL = setting("mail.smtp.user", "MAIL_SMTP_USER", "");
    private static final String SENDER_PASSWORD = normalizePassword(
            setting("mail.smtp.password", "MAIL_SMTP_PASSWORD", ""));

    private EmailUtil() {
    }

    private static String setting(String propertyName, String environmentName, String defaultValue) {
        String value = System.getProperty(propertyName);
        if (value == null || value.isBlank()) {
            value = System.getenv(environmentName);
        }
        if (value == null || value.isBlank()) {
            value = FILE_SETTINGS.getProperty(propertyName);
        }
        return value == null || value.isBlank() ? defaultValue : value.trim();
    }

    private static Properties loadFileSettings() {
        Properties properties = new Properties();
        try (InputStream input = EmailUtil.class.getClassLoader().getResourceAsStream("mail.properties")) {
            if (input != null) {
                properties.load(input);
            }
        } catch (IOException e) {
            System.err.println("SMTP configuration error: could not read mail.properties: " + e.getMessage());
        }
        return properties;
    }

    private static String normalizePassword(String password) {
        return password == null ? "" : password.replaceAll("\\s+", "");
    }

    public static boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    public static String generateOtp() {
        SecureRandom random = new SecureRandom();
        int number = random.nextInt(900000) + 100000;
        return String.valueOf(number);
    }

    public static boolean sendOtpEmail(String recipientEmail, String otp, String subject) {
        if (!isValidEmail(recipientEmail)) {
            System.err.println("SMTP configuration error: recipient email is invalid.");
            return false;
        }
        if (!isValidEmail(SENDER_EMAIL) || SENDER_PASSWORD.isBlank()) {
            System.err.println("SMTP configuration error: set MAIL_SMTP_USER and MAIL_SMTP_PASSWORD, "
                    + "JVM -Dmail.smtp.* properties, or src/main/resources/mail.properties.");
            return false;
        }

        try {
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.starttls.required", "true");
            props.put("mail.smtp.host", SMTP_HOST);
            props.put("mail.smtp.port", SMTP_PORT);
            props.put("mail.smtp.ssl.protocols", "TLSv1.2 TLSv1.3");
            props.put("mail.smtp.connectiontimeout", "10000");
            props.put("mail.smtp.timeout", "10000");
            props.put("mail.smtp.writetimeout", "10000");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
                }
            });

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL, "Web Portal Service", "UTF-8"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
            message.setSubject(subject, "UTF-8");

            String htmlContent = "<div style=\"font-family: Arial, sans-serif; max-width: 500px; margin: 0 auto; border: 1px solid #e0e0e0; border-radius: 8px; padding: 20px;\">"
                    + "<h2 style=\"color: #0d6efd; text-align: center;\">MÃ XÁC THỰC OTP</h2>"
                    + "<p>Xin chào,</p>"
                    + "<p>Bạn nhận được email này vì có một yêu cầu xác thực tài khoản từ hệ thống.</p>"
                    + "<div style=\"text-align: center; margin: 24px 0;\">"
                    + "<span style=\"font-size: 32px; font-weight: bold; letter-spacing: 6px; color: #198754; background: #e8f5e9; padding: 10px 24px; border-radius: 6px; display: inline-block;\">"
                    + otp + "</span>"
                    + "</div>"
                    + "<p style=\"color: #666; font-size: 14px;\">Mã OTP có hiệu lực trong vòng <b>5 phút</b>. Vui lòng không chia sẻ mã này cho bất kỳ ai.</p>"
                    + "<hr style=\"border: none; border-top: 1px solid #eee; margin: 20px 0;\" />"
                    + "<p style=\"font-size: 12px; color: #999; text-align: center;\">Hệ thống gửi thư tự động, vui lòng không phản hồi email này.</p>"
                    + "</div>";

            message.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(message);
            return true;
        } catch (Exception e) {
            System.err.println("SMTP notification failed (" + e.getClass().getSimpleName() + "): "
                    + e.getMessage());
            return false;
        }
    }
}
