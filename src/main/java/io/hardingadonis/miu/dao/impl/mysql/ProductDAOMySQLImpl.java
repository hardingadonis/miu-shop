package io.hardingadonis.miu.dao.impl.mysql;

import io.hardingadonis.miu.dao.*;
import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.services.*;
import java.sql.*;
import java.time.*;
import java.util.*;
import org.json.simple.*;
import org.json.simple.parser.*;

public class ProductDAOMySQLImpl implements ProductDAO {

    private static List<String> toList(String json) {
        List<String> list = new ArrayList<>();

        try {
            JSONArray arr = (JSONArray) new JSONParser().parse(json);
            for (Object img : arr) {
                list.add((String) img);
            }
        } catch (ParseException ex) {
            System.err.println(ex.getMessage());
        }

        return list;
    }

    private static String toJson(List<String> list) {
        JSONArray json = new JSONArray();

        for (String img : list) {
            json.add(img);
        }

        return json.toJSONString();
    }

    private static Product getFromResultSet(ResultSet rs) throws SQLException {
        int ID = rs.getInt("id");
        String brand = rs.getString("brand");
        String name = rs.getString("name");
        int categoryID = rs.getInt("category_id");
        String origin = rs.getString("origin");
        String expiryDate = rs.getString("expiry_date");
        String weight = rs.getString("weight");
        String preservation = rs.getString("preservation");
        long price = rs.getLong("price");
        int amount = rs.getInt("amount");
        String thumbnail = rs.getString("thumbnail");
        List<String> images = toList(rs.getString("images"));
        LocalDateTime createAt = Converter.convert(rs.getTimestamp("create_at"));
        LocalDateTime updateAt = Converter.convert(rs.getTimestamp("update_at"));
        LocalDateTime deleteAt = Converter.convert(rs.getTimestamp("delete_at"));

        return new Product(ID, brand, name, categoryID, origin, expiryDate, weight, preservation, price, amount, thumbnail, images, createAt, updateAt, deleteAt);
    }

    @Override
    public List<Product> getAll() {
        List<Product> list = new ArrayList<>();

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM product WHERE delete_at IS NULL");

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
    public List<Product> getAllByCategoryID(int categoryID) {
        List<Product> list = new ArrayList<>();

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM product WHERE delete_at IS NULL AND category_id = ?");
            smt.setInt(1, categoryID);

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
    public List<Product> getAllByPrice(int min, int max) {
        List<Product> list = new ArrayList<>();

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM product WHERE delete_at IS NULL AND price BETWEEN ? AND ?");
            smt.setInt(1, min);
            smt.setInt(2, max);

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
    public List<Product> getMostPopular(int limit) {
        List<Product> list = new ArrayList<>();

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM product WHERE delete_at IS NULL ORDER BY amount DESC LIMIT ?");
            smt.setInt(1, limit);

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
    public Product get(int ID) {
        Product product = null;

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM product WHERE id = ? AND delete_at IS NULL");
            smt.setInt(1, ID);

            ResultSet rs = smt.executeQuery();

            if (rs.next()) {
                product = getFromResultSet(rs);
            }

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }

        return product;
    }

    @Override
    public void insert(Product obj) {
        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("INSERT INTO product(brand, name, category_id, origin, expiry_date, weight, preservation, price, amount, thumbnail, images, create_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            smt.setString(1, obj.getBrand());
            smt.setString(2, obj.getName());
            smt.setInt(3, obj.getCategoryID());
            smt.setString(4, obj.getOrigin());
            smt.setString(5, obj.getExpiryDate());
            smt.setString(6, obj.getWeight());
            smt.setString(7, obj.getPreservation());
            smt.setLong(8, obj.getPrice());
            smt.setInt(9, obj.getAmount());
            smt.setString(10, obj.getThumbnail());
            smt.setString(11, toJson(obj.getImages()));
            smt.setString(12, Converter.convert(LocalDateTime.now()));

            smt.executeUpdate();

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }
    }

    @Override
    public void update(Product obj) {
        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("UPDATE product SET brand = ?, name = ?, category_id = ?, origin = ?, expiry_date = ?, weight = ?, preservation = ?, price = ?, amount = ?, thumbnail, images = ?, update_at = ? WHERE id = ? AND delete_at IS NULL");
            smt.setString(1, obj.getBrand());
            smt.setString(2, obj.getName());
            smt.setInt(3, obj.getCategoryID());
            smt.setString(4, obj.getOrigin());
            smt.setString(5, obj.getExpiryDate());
            smt.setString(6, obj.getWeight());
            smt.setString(7, obj.getPreservation());
            smt.setLong(8, obj.getPrice());
            smt.setInt(9, obj.getAmount());
            smt.setString(10, obj.getThumbnail());
            smt.setString(11, toJson(obj.getImages()));
            smt.setString(12, Converter.convert(LocalDateTime.now()));
            smt.setInt(13, obj.getID());

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

            PreparedStatement smt = conn.prepareStatement("UPDATE product SET delete_at = ? WHERE id = ? AND delete_at IS NULL");
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

            PreparedStatement smt = conn.prepareStatement("SELECT COUNT(*) FROM product WHERE delete_at IS NULL");

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
    public int countByCategoryID(int categoryID) {
        int count = 0;

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT COUNT(*) FROM product WHERE delete_at IS NULL AND category_id = ?");
            smt.setInt(1, categoryID);

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
    public int countByPrice(int min, int max) {
        int count = 0;

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT COUNT(*) FROM product WHERE delete_at IS NULL AND price BETWEEN ? AND ?");
            smt.setInt(1, min);
            smt.setInt(2, max);

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
