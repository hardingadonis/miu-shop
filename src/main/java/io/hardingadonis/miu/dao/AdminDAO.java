package io.hardingadonis.miu.dao;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.model.detail.*;
import java.util.*;

public interface AdminDAO {

    public List<Admin> getAll();

    public List<Admin> getAllByRole(AdminRole role);

    public Optional<Admin> get(int ID);

    public Optional<Admin> get(String username);

    public void insert(Admin obj);

    public void update(Admin obj);

    public void delete(int ID);

    public int count();

    public int countByRole(AdminRole role);
}
