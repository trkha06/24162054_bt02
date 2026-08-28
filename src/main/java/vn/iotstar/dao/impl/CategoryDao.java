package vn.iotstar.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.dao.ICategoryDao;
import vn.iotstar.entity.Category;

public class CategoryDao implements ICategoryDao {

    @Override
    public void insert(Category category) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(category);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void update(Category category) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(category);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void delete(int cateid) throws Exception {
        EntityManager entityManager = JpaConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Category category = entityManager.find(Category.class, cateid);
            if (category != null) {
                entityManager.remove(category);
            } else {
                throw new IllegalArgumentException("Không tìm thấy danh mục có mã " + cateid);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        } finally {
            entityManager.close();
        }
    }

    @Override
    public Category findById(int cateid) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            return entityManager.find(Category.class, cateid);
        } finally {
            entityManager.close();
        }
    }

    @Override
    public Category findByCategoryname(String name) throws Exception {
        EntityManager entityManager = JpaConfig.getEntityManager();
        String jpql = "SELECT c FROM Category c WHERE LOWER(c.categoryname) = LOWER(:categoryname)";
        try {
            return entityManager.createQuery(jpql, Category.class)
                    .setParameter("categoryname", name.trim())
                    .setMaxResults(1)
                    .getResultStream()
                    .findFirst()
                    .orElse(null);
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Category> findAll() {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            TypedQuery<Category> query = entityManager.createNamedQuery("Category.findAll", Category.class);
            return query.getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Category> searchByName(String catname) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        String jpql = "SELECT c FROM Category c WHERE LOWER(c.categoryname) LIKE LOWER(:catname) "
                + "ORDER BY c.categoryid";
        try {
            TypedQuery<Category> query = entityManager.createQuery(jpql, Category.class);
            query.setParameter("catname", "%" + catname + "%");
            return query.getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Category> findAll(int page, int pagesize) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            TypedQuery<Category> query = entityManager.createNamedQuery("Category.findAll", Category.class);
            query.setFirstResult(page * pagesize);
            query.setMaxResults(pagesize);
            return query.getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public int count() {
        EntityManager entityManager = JpaConfig.getEntityManager();
        String jpql = "SELECT count(c) FROM Category c";
        try {
            return entityManager.createQuery(jpql, Long.class).getSingleResult().intValue();
        } finally {
            entityManager.close();
        }
    }
}
