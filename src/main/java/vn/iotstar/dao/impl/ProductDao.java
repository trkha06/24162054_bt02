package vn.iotstar.dao.impl;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.dao.IProductDao;
import vn.iotstar.entity.Product;

public class ProductDao implements IProductDao {

    @Override
    public void insert(Product product) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(product);
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
    public void update(Product product) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(product);
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
    public void delete(int productId) throws Exception {
        EntityManager entityManager = JpaConfig.getEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Product product = entityManager.find(Product.class, productId);
            if (product != null) {
                entityManager.remove(product);
            } else {
                throw new IllegalArgumentException("Không tìm thấy sản phẩm có mã " + productId);
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
    public Product findById(int productId) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            return entityManager.find(Product.class, productId);
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Product> findAll() {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            TypedQuery<Product> query = entityManager.createNamedQuery("Product.findAll", Product.class);
            return query.getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Product> findAll(int page, int pageSize) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        try {
            TypedQuery<Product> query = entityManager.createNamedQuery("Product.findAll", Product.class);
            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Product> findTop10Recent() {
        EntityManager entityManager = JpaConfig.getEntityManager();
        String jpql = "SELECT p FROM Product p ORDER BY p.createDate DESC, p.productId DESC";
        try {
            TypedQuery<Product> query = entityManager.createQuery(jpql, Product.class);
            query.setMaxResults(10);
            return query.getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Product> findByCategoryId(int categoryId, int page, int pageSize) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        String jpql = "SELECT p FROM Product p WHERE p.category.categoryid = :catId ORDER BY p.productId DESC";
        try {
            TypedQuery<Product> query = entityManager.createQuery(jpql, Product.class);
            query.setParameter("catId", categoryId);
            query.setFirstResult(page * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Product> searchByName(String keyword) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        String jpql = "SELECT p FROM Product p WHERE LOWER(p.productName) LIKE LOWER(:keyword) ORDER BY p.productId DESC";
        try {
            TypedQuery<Product> query = entityManager.createQuery(jpql, Product.class);
            query.setParameter("keyword", "%" + keyword + "%");
            return query.getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public int count() {
        EntityManager entityManager = JpaConfig.getEntityManager();
        String jpql = "SELECT COUNT(p) FROM Product p";
        try {
            return entityManager.createQuery(jpql, Long.class).getSingleResult().intValue();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public int countByCategoryId(int categoryId) {
        EntityManager entityManager = JpaConfig.getEntityManager();
        String jpql = "SELECT COUNT(p) FROM Product p WHERE p.category.categoryid = :catId";
        try {
            return entityManager.createQuery(jpql, Long.class)
                    .setParameter("catId", categoryId)
                    .getSingleResult()
                    .intValue();
        } finally {
            entityManager.close();
        }
    }
}
