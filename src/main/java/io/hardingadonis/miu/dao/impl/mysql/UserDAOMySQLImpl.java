package io.hardingadonis.miu.dao.impl.mysql;

import io.hardingadonis.miu.dao.*;
import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.model.detail.*;
import io.hardingadonis.miu.services.*;
import java.sql.*;
import java.time.*;
import java.util.*;
import org.json.simple.*;
import org.json.simple.parser.*;

public class UserDAOMySQLImpl implements UserDAO {

    private static List<String> toList(String json) {
        List<String> list = new ArrayList<>();

        try {
            JSONArray arr = (JSONArray) new JSONParser().parse(json);

            for (Object address : arr) {
                list.add((String) address);
            }
        } catch (ParseException ex) {
            System.err.println(ex.getMessage());
        }

        return list;
    }

    private static String toJson(List<String> list) {
        JSONArray json = new JSONArray();

        for (String address : list) {
            json.add(address);
        }

        return json.toJSONString();
    }

    private static User getFromResultSet(ResultSet rs) throws SQLException {
        int ID = rs.getInt("id");
        String fullName = rs.getString("full_name");
        int birthYear = rs.getInt("birth_year");
        UserGender gender = UserGender.create(rs.getString("gender"));
        String email = rs.getString("email");
        String hashedPassword = rs.getString("hashed_password");
        String avatarPath = rs.getString("avatar_path");
        List<String> address = toList(rs.getString("address"));
        UserStatus status = UserStatus.create(rs.getString("status"));
        LocalDateTime createAt = Converter.convert(rs.getTimestamp("create_at"));
        LocalDateTime updateAt = Converter.convert(rs.getTimestamp("update_at"));
        LocalDateTime deleteAt = Converter.convert(rs.getTimestamp("delete_at"));

        return new User(ID, fullName, birthYear, gender, email, hashedPassword, avatarPath, address, status, createAt, updateAt, deleteAt);
    }

    @Override
    public List<User> getAll() {
        List<User> list = new ArrayList<>();

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM user WHERE delete_at IS NULL");

            ResultSet rs = smt.executeQuery();

            while (rs.next()) {
                list.add(getFromResultSet(rs));
            }

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }

        return list;
    }

    @Override
    public List<User> getAllByUserGender(UserGender gender) {
        List<User> list = new ArrayList<>();

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM user WHERE delete_at IS NULL AND gender = ?");
            smt.setString(1, gender.toString());

            ResultSet rs = smt.executeQuery();

            while (rs.next()) {
                list.add(getFromResultSet(rs));
            }

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }

        return list;
    }

    @Override
    public List<User> getAllByUserStatus(UserStatus status) {
        List<User> list = new ArrayList<>();

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM user WHERE delete_at IS NULL AND status = ?");
            smt.setString(1, status.toString());

            ResultSet rs = smt.executeQuery();

            while (rs.next()) {
                list.add(getFromResultSet(rs));
            }

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }

        return list;
    }

    @Override
    public User get(int ID) {
        User user = null;

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM user WHERE id = ? AND delete_at IS NULL");
            smt.setInt(1, ID);

            ResultSet rs = smt.executeQuery();

            if (rs.next()) {
                user = getFromResultSet(rs);
            }

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }

        return user;
    }

    @Override
    public User get(String email) {
        User user = null;

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM user WHERE email = ? AND delete_at IS NULL");
            smt.setString(1, email);

            ResultSet rs = smt.executeQuery();

            if (rs.next()) {
                user = getFromResultSet(rs);
            }

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }

        return user;
    }

    @Override
    public void insert(User obj) {
        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("INSERT INTO user(full_name, birth_year, gender, email, hashed_password, avatar_path, address, status, create_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
            smt.setString(1, obj.getFullName());
            smt.setInt(2, obj.getBirthYear());
            smt.setString(3, obj.getGender().toString());
            smt.setString(4, obj.getEmail());
            smt.setString(5, obj.getHashedPassword());
            smt.setString(6, obj.getAvatarPath());
            smt.setString(7, toJson(obj.getAddress()));
            smt.setString(8, obj.getStatus().toString());
            smt.setString(9, Converter.convert(LocalDateTime.now()));

            smt.executeUpdate();

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }
    }

    @Override
    public void update(User obj) {
        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("UPDATE user SET full_name = ?, birth_year = ?, gender = ?, email = ?, hashed_password = ?, avatar_path = ?, address = ?, status = ?, update_at = ? WHERE id = ? AND delete_at IS NULL");
            smt.setString(1, obj.getFullName());
            smt.setInt(2, obj.getBirthYear());
            smt.setString(3, obj.getGender().toString());
            smt.setString(4, obj.getEmail());
            smt.setString(5, obj.getHashedPassword());
            smt.setString(6, obj.getAvatarPath());
            smt.setString(7, toJson(obj.getAddress()));
            smt.setString(8, obj.getStatus().toString());
            smt.setString(9, Converter.convert(LocalDateTime.now()));
            smt.setInt(10, obj.getID());

            smt.executeUpdate();

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }
    }

    @Override
    public void delete(int ID) {
        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("UPDATE user SET delete_at = ? WHERE id = ? AND delete_at IS NULL");
            smt.setString(1, Converter.convert(LocalDateTime.now()));
            smt.setInt(2, ID);

            smt.executeUpdate();

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }
    }

    @Override
    public int count() {
        int count = 0;

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT COUNT(*) FROM user WHERE delete_at IS NULL");

            ResultSet rs = smt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }

        return count;
    }

    @Override
    public int countByUserGender(UserGender gender) {
        int count = 0;

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT COUNT(*) FROM user WHERE delete_at IS NULL AND gender = ?");
            smt.setString(1, gender.toString());

            ResultSet rs = smt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }

        return count;
    }

    @Override
    public int countByUserStatus(UserStatus status) {
        int count = 0;

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT COUNT(*) FROM user WHERE delete_at IS NULL AND status = ?");
            smt.setString(1, status.toString());

            ResultSet rs = smt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }

        return count;
    }
}
