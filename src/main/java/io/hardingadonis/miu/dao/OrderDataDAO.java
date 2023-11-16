package io.hardingadonis.r7.dao;

import io.hardingadonis.r7.model.*;
import java.util.*;

public interface OrderDataDAO {

    public List<OrderData> getAll(int orderID);

    public void insert(OrderData obj);
}