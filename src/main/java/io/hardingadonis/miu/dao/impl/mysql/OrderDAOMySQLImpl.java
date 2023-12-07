package io.hardingadonis.miu.dao.impl.mysql;

import io.hardingadonis.miu.dao.*;
import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.model.detail.*;
import io.hardingadonis.miu.services.*;
import java.sql.*;
import java.time.*;
import java.util.*;

public class OrderDAOMySQLImpl implements OrderDAO {

    private static Order getFromResultSet(ResultSet rs) throws SQLException {
        int ID = rs.getInt("id");
        int userID = rs.getInt("user_id");
        String address = rs.getString("address");
        long totalPrice = rs.getInt("total_price");
        Payment payment = Payment.create(rs.getString("payment"));
        OrderStatus status = OrderStatus.create(rs.getString("status"));
        LocalDateTime createAt = Converter.convert(rs.getTimestamp("create_at"));
        LocalDateTime updateAt = Converter.convert(rs.getTimestamp("update_at"));

        return new Order(ID, userID, address, totalPrice, payment, status, createAt, updateAt);
    }

    @Override
    public List<Order> getAll() {
        List<Order> list = new ArrayList<>();

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM `order`");

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
    public List<Order> getAllByUserID(int userID) {
        List<Order> list = new ArrayList<>();

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM `order` WHERE user_id = ?");
            smt.setInt(1, userID);

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
    public List<Order> getAllByPayment(Payment payment) {
        List<Order> list = new ArrayList<>();

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM `order` WHERE payment = ?");
            smt.setString(1, payment.toString());

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
    public List<Order> getAllByOrderStatus(OrderStatus status) {
        List<Order> list = new ArrayList<>();

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM `order` WHERE status = ?");
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
    public List<Order> getAllWithUserID(int userID, int offset, int limit) {
        List<Order> list = new ArrayList<>();

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM `order` WHERE user_id = ? ORDER BY create_at DESC LIMIT ?, ?");
            smt.setInt(1, userID);
            smt.setInt(2, offset);
            smt.setInt(3, limit);

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
    public List<Order> getAllWithUserIDAndStatus(int userID, OrderStatus status, int offset, int limit) {
        List<Order> list = new ArrayList<>();

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM `order` WHERE user_id = ? AND `status` = ? ORDER BY create_at DESC LIMIT ?, ?");
            smt.setInt(1, userID);
            smt.setString(2, status.toString());
            smt.setInt(3, offset);
            smt.setInt(4, limit);

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
    public Order get(int ID) {
        Order order = null;

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT * FROM `order` WHERE id = ?");
            smt.setInt(1, ID);

            ResultSet rs = smt.executeQuery();

            if (rs.next()) {
                order = getFromResultSet(rs);
            }

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }

        return order;
    }

    @Override
    public int insert(Order obj) {
        int id = 0;

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("INSERT INTO `order`(user_id, address, total_price, payment, status, create_at) VALUES (?, ?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
            smt.setInt(1, obj.getUserID());
            smt.setString(2, obj.getAddress());
            smt.setLong(3, obj.getTotalPrice());
            smt.setString(4, obj.getPayment().toString());
            smt.setString(5, obj.getStatus().toString());
            smt.setString(6, Converter.convert(LocalDateTime.now()));

            if (smt.executeUpdate() > 0) {
                ResultSet rs = smt.getGeneratedKeys();

                if (rs.next()) {
                    id = rs.getInt(1);
                }
            }

            Singleton.dbContext.closeConnection(conn);
        } catch (SQLException ex) {
            System.err.println(ex.getMessage());
        }

        return id;
    }

    @Override
    public void update(Order obj) {
        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("UPDATE `order` SET user_id = ?, address = ?, total_price = ?, payment = ?, status = ?, update_at = ? WHERE id = ?");
            smt.setInt(1, obj.getUserID());
            smt.setString(2, obj.getAddress());
            smt.setLong(3, obj.getTotalPrice());
            smt.setString(4, obj.getPayment().toString());
            smt.setString(5, obj.getStatus().toString());
            smt.setString(6, Converter.convert(LocalDateTime.now()));
            smt.setInt(7, obj.getID());

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

            PreparedStatement smt = conn.prepareStatement("SELECT COUNT(*) FROM `order`");

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
    public int countByUserID(int userID) {
        int count = 0;

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT COUNT(*) FROM `order` WHERE user_id = ?");
            smt.setInt(1, userID);

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
    public int countByPayment(Payment payment) {
        int count = 0;

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT COUNT(*) FROM `order` WHERE payment = ?");
            smt.setString(1, payment.toString());

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
    public int countByOrderStatus(OrderStatus status) {
        int count = 0;

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT COUNT(*) FROM `order` WHERE status = ?");
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

    @Override
    public int countAllWithUserIDAndStatus(int userID, OrderStatus status) {
        int count = 0;

        try {
            Connection conn = Singleton.dbContext.getConnection();

            PreparedStatement smt = conn.prepareStatement("SELECT COUNT(*) FROM `order` WHERE user_id = ? AND status = ?");
            smt.setInt(1, userID);
            smt.setString(2, status.toString());

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
