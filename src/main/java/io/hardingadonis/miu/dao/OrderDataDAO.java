package io.hardingadonis.miu.dao;

import io.hardingadonis.miu.model.*;
import java.util.*;

public interface OrderDataDAO {

    public List<OrderData> getAll(int orderID);

    public void insert(OrderData obj);
}
