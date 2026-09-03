package vn.iotstar.dao.impl;

import java.sql.Date;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.dao.UserDao;
import vn.iotstar.entity.User;

public class UserDaoImpl implements UserDao {

    private static final List<User> MEMORY_USERS = new CopyOnWriteArrayList<>();

    static {
        Date createdDate = Date.valueOf("2026-06-24");
        MEMORY_USERS.add(new User(1, "admin@ute.edu.vn", "admin", "Quản Trị Viên", "123456", null, 1,
                "0901234567", createdDate));
        MEMORY_USERS.add(new User(2, "manager@ute.edu.vn", "manager", "Quản Lý Cửa Hàng", "123456", null, 2,
                "0907654321", createdDate));
        MEMORY_USERS.add(new User(3, "24162054@student.hcmute.edu.vn", "24162054", "Võ Văn Trường Kha", "123",
                null, 1, "0908617108", createdDate));
        MEMORY_USERS.add(new User(4, "trungnh@hcmute.edu.vn", "trungnh", "ThS. Nguyễn Hữu Trung", "123", null, 5,
                "0900000000", createdDate));
    }

    @Override
    public User findById(int id) {
        try {
            EntityManager entityManager = JpaConfig.getEntityManager();
            try {
                return entityManager.find(User.class, id);
            } finally {
                entityManager.close();
            }
        } catch (Exception exception) {
            System.err.println("Cannot find user by id from JPA: " + exception.getMessage());
            return MEMORY_USERS.stream().filter(u -> u.getId() == id).findFirst().orElse(null);
        }
    }

    @Override
    public User get(String username) {
        return findByUsername(username);
    }

    @Override
    public User findByUsername(String username) {
        if (username == null || username.isBlank()) {
            return null;
        }
        try {
            EntityManager entityManager = JpaConfig.getEntityManager();
            try {
                String jpql = "SELECT u FROM User u WHERE LOWER(u.userName) = LOWER(:username)";
                return entityManager.createQuery(jpql, User.class)
                        .setParameter("username", username.trim())
                        .setMaxResults(1)
                        .getResultStream()
                        .findFirst()
                        .orElse(null);
            } finally {
                entityManager.close();
            }
        } catch (Exception exception) {
            System.err.println("Cannot read user from JPA; using fallback: " + exception.getMessage());
            return MEMORY_USERS.stream()
                    .filter(u -> u.getUserName().equalsIgnoreCase(username.trim()))
                    .findFirst()
                    .orElse(null);
        }
    }

    @Override
    public User findByEmail(String email) {
        if (email == null || email.isBlank()) {
            return null;
        }
        try {
            EntityManager entityManager = JpaConfig.getEntityManager();
            try {
                String jpql = "SELECT u FROM User u WHERE LOWER(u.email) = LOWER(:email)";
                return entityManager.createQuery(jpql, User.class)
                        .setParameter("email", email.trim())
                        .setMaxResults(1)
                        .getResultStream()
                        .findFirst()
                        .orElse(null);
            } finally {
                entityManager.close();
            }
        } catch (Exception exception) {
            return MEMORY_USERS.stream()
                    .filter(u -> u.getEmail().equalsIgnoreCase(email.trim()))
                    .findFirst()
                    .orElse(null);
        }
    }

    @Override
    public void insert(User user) {
        try {
            EntityManager entityManager = JpaConfig.getEntityManager();
            EntityTransaction transaction = entityManager.getTransaction();
            try {
                transaction.begin();
                entityManager.persist(user);
                transaction.commit();
            } catch (Exception e) {
                if (transaction.isActive()) {
                    transaction.rollback();
                }
                throw e;
            } finally {
                entityManager.close();
            }
        } catch (Exception exception) {
            System.err.println("Cannot insert user with JPA: " + exception.getMessage());
        }

        if (MEMORY_USERS.stream().noneMatch(item -> item.getUserName().equalsIgnoreCase(user.getUserName()))) {
            MEMORY_USERS.add(user);
        }
    }

    @Override
    public void update(User user) {
        try {
            EntityManager entityManager = JpaConfig.getEntityManager();
            EntityTransaction transaction = entityManager.getTransaction();
            try {
                transaction.begin();
                entityManager.merge(user);
                transaction.commit();
            } catch (Exception e) {
                if (transaction.isActive()) {
                    transaction.rollback();
                }
                throw e;
            } finally {
                entityManager.close();
            }
        } catch (Exception exception) {
            System.err.println("Cannot update user with JPA: " + exception.getMessage());
        }

        for (int i = 0; i < MEMORY_USERS.size(); i++) {
            if (MEMORY_USERS.get(i).getId() == user.getId()
                    || MEMORY_USERS.get(i).getUserName().equalsIgnoreCase(user.getUserName())) {
                MEMORY_USERS.set(i, user);
                break;
            }
        }
    }

    @Override
    public boolean checkExistEmail(String email) {
        if (email == null || email.isBlank()) {
            return false;
        }
        try {
            EntityManager entityManager = JpaConfig.getEntityManager();
            try {
                String jpql = "SELECT count(u) FROM User u WHERE LOWER(u.email) = LOWER(:email)";
                Long count = entityManager.createQuery(jpql, Long.class)
                        .setParameter("email", email.trim())
                        .getSingleResult();
                return count != null && count > 0;
            } finally {
                entityManager.close();
            }
        } catch (Exception exception) {
            return MEMORY_USERS.stream().anyMatch(u -> u.getEmail().equalsIgnoreCase(email.trim()));
        }
    }

    @Override
    public boolean checkExistUsername(String username) {
        if (username == null || username.isBlank()) {
            return false;
        }
        try {
            EntityManager entityManager = JpaConfig.getEntityManager();
            try {
                String jpql = "SELECT count(u) FROM User u WHERE LOWER(u.userName) = LOWER(:username)";
                Long count = entityManager.createQuery(jpql, Long.class)
                        .setParameter("username", username.trim())
                        .getSingleResult();
                return count != null && count > 0;
            } finally {
                entityManager.close();
            }
        } catch (Exception exception) {
            return MEMORY_USERS.stream().anyMatch(u -> u.getUserName().equalsIgnoreCase(username.trim()));
        }
    }

    @Override
    public boolean checkExistPhone(String phone) {
        if (phone == null || phone.isBlank()) {
            return false;
        }
        try {
            EntityManager entityManager = JpaConfig.getEntityManager();
            try {
                String jpql = "SELECT count(u) FROM User u WHERE u.phone = :phone";
                Long count = entityManager.createQuery(jpql, Long.class)
                        .setParameter("phone", phone.trim())
                        .getSingleResult();
                return count != null && count > 0;
            } finally {
                entityManager.close();
            }
        } catch (Exception exception) {
            return MEMORY_USERS.stream().anyMatch(u -> phone.trim().equals(u.getPhone()));
        }
    }

    @Override
    public boolean checkExistPhoneExceptUser(String phone, int userId) {
        if (phone == null || phone.isBlank()) {
            return false;
        }
        try {
            EntityManager entityManager = JpaConfig.getEntityManager();
            try {
                String jpql = "SELECT count(u) FROM User u WHERE u.phone = :phone AND u.id <> :userId";
                Long count = entityManager.createQuery(jpql, Long.class)
                        .setParameter("phone", phone.trim())
                        .setParameter("userId", userId)
                        .getSingleResult();
                return count != null && count > 0;
            } finally {
                entityManager.close();
            }
        } catch (Exception exception) {
            return MEMORY_USERS.stream()
                    .anyMatch(u -> u.getId() != userId && phone.trim().equals(u.getPhone()));
        }
    }

    @Override
    public List<User> findAll() {
        try {
            EntityManager entityManager = JpaConfig.getEntityManager();
            try {
                TypedQuery<User> query = entityManager.createNamedQuery("User.findAll", User.class);
                return query.getResultList();
            } finally {
                entityManager.close();
            }
        } catch (Exception exception) {
            return MEMORY_USERS;
        }
    }
}
