package io.hardingadonis.miu.dao;

import io.hardingadonis.miu.model.*;
import io.hardingadonis.miu.model.detail.*;
import java.util.*;

public interface UserDAO {

    public List<User> getAll();

    public List<User> getAllByUserGender(UserGender gender);

    public List<User> getAllByUserStatus(UserStatus status);

    public Optional<User> get(int ID);

    public Optional<User> get(String email);

    public void insert(User obj);

    public void update(User obj);

    public void delete(int ID);

    public int count();

    public int countByUserGender(UserGender gender);

    public int countByUserStatus(UserStatus status);
}