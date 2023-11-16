package io.hardingadonis.miu.dao;

import io.hardingadonis.miu.model.*;
import java.util.*;

public interface CategoryDAO {

    public List<Category> getAll();

    public List<Category> getAllByParentID(int parentID);

    public Optional<Category> get(int ID);

    public void insert(Category obj);

    public void update(Category obj);

    public void delete(int ID);

    public int count();
}
