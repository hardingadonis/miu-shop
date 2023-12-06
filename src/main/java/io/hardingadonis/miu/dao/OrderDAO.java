package io.hardingadonis.miu.dao;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.model.detail.*;
import java.util.*;

public interface OrderDAO {

    public List<Order> getAll();

    public List<Order> getAllByUserID(int userID);

    public List<Order> getAllByPayment(Payment payment);

    public List<Order> getAllByOrderStatus(OrderStatus status);

    public List<Order> getAllWithUserID(int userID, int offset, int limit);

    public List<Order> getAllWithUserIDAndStatus(int userID, OrderStatus status, int offset, int limit);

    public Order get(int ID);

    public int insert(Order obj);

    public void update(Order obj);

    public int count();

    public int countByUserID(int userID);

    public int countByPayment(Payment payment);

    public int countByOrderStatus(OrderStatus status);

    public int countAllWithUserIDAndStatus(int userID, OrderStatus status);
}
