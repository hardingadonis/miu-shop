package io.hardingadonis.miu.dao;

import io.hardingadonis.miu.model.*;
import java.util.*;

public interface CategoryDAO {

    public List<Category> getAll();

    public Category get(int ID);

    public void insert(Category obj);

    public void update(Category obj);

    public void delete(int ID);

    public int count();

    public String getNameCategory(int ID);

}
