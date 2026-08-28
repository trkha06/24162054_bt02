package vn.iotstar.services.impl;

import java.util.List;

import vn.iotstar.dao.ICategoryDao;
import vn.iotstar.dao.impl.CategoryDao;
import vn.iotstar.entity.Category;
import vn.iotstar.services.ICategoryService;

public class CategoryServiceImpl implements ICategoryService {

    private final ICategoryDao categoryDao = new CategoryDao();

    @Override
    public List<Category> findAll() {
        return categoryDao.findAll();
    }

    @Override
    public Category findById(int id) {
        return categoryDao.findById(id);
    }

    @Override
    public List<Category> searchByName(String keyword) {
        return categoryDao.searchByName(keyword == null ? "" : keyword.trim());
    }

    @Override
    public void insert(Category category) {
        normalizeAndValidate(category);
        if (findByCategoryname(category.getCategoryname()) != null) {
            throw new IllegalArgumentException("Tên danh mục đã tồn tại.");
        }
        categoryDao.insert(category);
    }

    @Override
    public void update(Category category) {
        normalizeAndValidate(category);
        if (findById(category.getCategoryid()) == null) {
            throw new IllegalArgumentException("Danh mục không tồn tại.");
        }
        Category duplicate = findByCategoryname(category.getCategoryname());
        if (duplicate != null && duplicate.getCategoryid() != category.getCategoryid()) {
            throw new IllegalArgumentException("Tên danh mục đã tồn tại.");
        }
        categoryDao.update(category);
    }

    @Override
    public void delete(int id) throws Exception {
        categoryDao.delete(id);
    }

    @Override
    public int count() {
        return categoryDao.count();
    }

    @Override
    public List<Category> findAll(int page, int pagesize) {
        int safePage = Math.max(page, 0);
        int safePageSize = Math.max(pagesize, 1);
        return categoryDao.findAll(safePage, safePageSize);
    }

    @Override
    public Category findByCategoryname(String name) {
        if (name == null || name.isBlank()) {
            return null;
        }
        try {
            return categoryDao.findByCategoryname(name.trim());
        } catch (Exception exception) {
            throw new IllegalStateException("Không thể tìm danh mục.", exception);
        }
    }

    private void normalizeAndValidate(Category category) {
        if (category == null || category.getCategoryname() == null || category.getCategoryname().isBlank()) {
            throw new IllegalArgumentException("Tên danh mục không được để trống.");
        }
        String name = category.getCategoryname().trim();
        if (name.length() > 100) {
            throw new IllegalArgumentException("Tên danh mục tối đa 100 ký tự.");
        }
        category.setCategoryname(name);
        category.setStatus(category.getStatus() == 1 ? 1 : 0);
    }
}
