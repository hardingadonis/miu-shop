package io.hardingadonis.miu.controller.web;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.model.detail.*;
import io.hardingadonis.miu.services.*;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import org.apache.commons.fileupload.*;
import org.apache.commons.fileupload.disk.*;
import org.apache.commons.fileupload.servlet.*;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
@MultipartConfig
public class ProfileServlet extends HttpServlet {

    public static final String UPLOAD_AVATAR_DIRECTORY = "assets/images/avatars";

    public static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;
    public static final int MAX_FILE_SIZE = 1024 * 1024 * 3;
    public static final int MAX_REQUEST_SIZE = 1024 * 1024 * 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        request.setAttribute("gender", user.getGender().toString());

        request.getRequestDispatcher("/view/web/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        User user = (User) request.getSession().getAttribute("user");

        try {
            String uploadPath = getServletContext().getRealPath("") + UPLOAD_AVATAR_DIRECTORY;

            DiskFileItemFactory factory = new DiskFileItemFactory(MEMORY_THRESHOLD, new File(System.getProperty("java.io.tmpdir")));

            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setFileSizeMax(MAX_FILE_SIZE);
            upload.setSizeMax(MAX_REQUEST_SIZE);

            List<FileItem> items = upload.parseRequest(request);

            for (FileItem item : items) {
                if (!item.isFormField() && item.getSize() > 0) {
                    String fileName = new File(item.getName()).getName();
                    fileName = Hash.SHA256(fileName + System.currentTimeMillis()) + "." + getFileExtension(fileName);

                    String filePath = uploadPath + File.separator + fileName;

                    File storeFile = new File(filePath);
                    if (!storeFile.exists()) {
                        item.write(storeFile);
                        user.setAvatarPath(UPLOAD_AVATAR_DIRECTORY + File.separator + fileName);
                    }
                } else {
                    switch (item.getFieldName()) {
                        case "full-name": {
                            String fullName = item.getString("UTF-8");
                            user.setFullName(fullName);
                            break;
                        }

                        case "birth-year": {
                            int birthYear = Integer.parseInt(item.getString("UTF-8"));
                            user.setBirthYear(birthYear);
                            break;
                        }

                        case "gender": {
                            UserGender gender = UserGender.create(item.getString("UTF-8"));
                            user.setGender(gender);
                            break;
                        }
                    }
                }
            }
        } catch (Exception ex) {
            System.err.println(ex.getMessage());
        }

        Singleton.userDAO.update(user);

        this.doGet(request, response);
    }

    private static String getFileExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf('.');

        if (dotIndex > 0 && dotIndex < fileName.length() - 1) {
            return fileName.substring(dotIndex + 1);
        } else {
            return "";
        }
    }
}
