package com.FashionStore.dao;

import java.util.List;
import com.FashionStore.model.User;

public interface UserDAO {
    boolean registerUser(User user);
    User loginUser(String email, String password);
    User getUserById(int userId);
    User getUserByEmail(String email);
    boolean updateUser(User user);
    boolean changePassword(int userId, String newPassword);
    boolean isEmailRegistered(String email);
    List<User> getAllUsers();
    boolean deleteUser(int userId);
}