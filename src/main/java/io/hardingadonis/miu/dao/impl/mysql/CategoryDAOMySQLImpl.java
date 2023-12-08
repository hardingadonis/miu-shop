package io.hardingadonis.miu.dao.impl.mysql;

import io.hardingadonis.miu.dao.*;
import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.services.*;
import java.sql.*;
import java.time.*;
import java.util.*;

public class CategoryDAOMySQLImpl implements CategoryDAO {

    private static Category getFromResultSet(ResultSet rs) throws SQLException {
        int ID = rs.getInt("id");
        String name = rs.getString("name");
        LocalDateTime createAt = Converter.convert(rs.getTimestamp("create_at"));
        LocalDateTime updateAt = Converter.convert(rs.getTimestamp("update_at"));
        LocalDateTime deleteAt = Converter.convert(rs.getTimestamp("delete_at"));

        return new Category(ID, name, createAt, updateAt, deleteAt);
    }

    @Override
    public List<Category> getAll() {
        List<Category> list = new ArrayList<>();

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM category WHERE delete_at IS NULL");

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
    public Category get(int ID) {
        Category category = null;

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM category WHERE id = ? AND delete_at IS NULL");
            smt.setInt(1, ID);

            ResultSet rs = smt.executeQuery();

            if (rs.next()) {
                category = getFromResultSet(rs);
            }

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }

        return category;
    }

    public String getNameCategory(int ID) {
        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT name FROM category WHERE id = ? AND delete_at IS NULL");
            smt.setInt(1, ID);

            ResultSet rs = smt.executeQuery();

            if (rs.next()) {
                return rs.getString("name");
            }

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }
        return null;
    }

    @Override
    public void insert(Category obj) {
        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("INSERT INTO category(name, create_at) VALUES (?, ?)");
            smt.setString(1, obj.getName());
            smt.setString(2, Converter.convert(LocalDateTime.now()));

            smt.executeUpdate();

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }
    }

    @Override
    public void update(Category obj) {
        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("UPDATE category SET name = ?, update_at = ? WHERE id = ? AND delete_at IS NULL");
            smt.setString(1, obj.getName());
            smt.setString(2, Converter.convert(LocalDateTime.now()));
            smt.setInt(3, obj.getID());

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

            PreparedStatement smt = conn.prepareStatement("UPDATE category SET delete_at = ? WHERE id = ? AND delete_at IS NULL");
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

            PreparedStatement smt = conn.prepareStatement("SELECT COUNT(*) FROM category WHERE delete_at IS NULL");

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
