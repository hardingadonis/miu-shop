package io.hardingadonis.miu.dao;

import io.hardingadonis.miu.model.*;
import java.util.*;

public interface CartDAO {

    public List<Cart> getAll(int userID);

    public void insert(Cart obj);

    public void update(Cart obj);

    public void delete(int userID, int productID);

    public void deleteAll(int userID);
}
