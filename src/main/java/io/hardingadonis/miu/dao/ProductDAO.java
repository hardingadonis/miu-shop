package io.hardingadonis.miu.dao;

import io.hardingadonis.miu.model.*;
import java.util.*;

public interface ProductDAO {

    public List<Product> getAll();

    public List<Product> getAllByCategoryID(int categoryID);

    public List<Product> getAllByPrice(int min, int max);
    
    public List<Product> getRandom(int limit);
    
    public List<Product> getBySearch(String name, int categoryID, int offset, int limit);

    public Product get(int ID);

    public void insert(Product obj);

    public void update(Product obj);

    public void delete(int ID);

    public int count();

    public int countByCategoryID(int categoryID);

    public int countByPrice(int min, int max);
    
    public int countBySerach(String searchName, int categoryID);
}