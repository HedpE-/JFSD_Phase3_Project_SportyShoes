package jfsd.assessments.phase3.SportyShoes.util;

import java.util.Date;
import java.util.List;

import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import jfsd.assessments.phase3.SportyShoes.entity.Brand;
import jfsd.assessments.phase3.SportyShoes.entity.Category;
import jfsd.assessments.phase3.SportyShoes.entity.Purchase;
import jfsd.assessments.phase3.SportyShoes.entity.Shoe;
import jfsd.assessments.phase3.SportyShoes.entity.User;

@Repository("crudHelper")
public class CrudHelper {
	private SessionFactory factory = HibernateUtility.getSessionFactory();

	//
	// Users
	//

	public User getUser(String username) {
		User user = null;
		Session session = null;
		try {
			session = factory.openSession();
			Query<User> query = session.createQuery("FROM User where username=:username", User.class);
			query.setParameter("username", username);
			user = query.getSingleResult();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (session != null && session.isOpen())
					session.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return user;
	}

	public List<User> getUsers() {
		return getQueryList(User.class);
	}

	public List<User> getUsers(int maxRows) {
		return getQueryList(User.class, maxRows);
	}

	public List<User> getUsersByLastLogin() {
		Session session = null;
		try {
			session = factory.openSession();
			Query<User> query = session.createQuery("FROM User ORDER BY last_login DESC", User.class);
			List<User> users = query.list();			
			return users;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (session != null && session.isOpen())
					session.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public void registerUser(User user) {
		add(user);
	}

	public void updateUser(User user) {
		update(user);
	}

	public void deleteUser(String username) {
		User user = getUser(username);
		delete(user);
	}

	//
	// Shoes
	//

	public List<Shoe> getShoes(int categoryId, int brandId) {
		Session session = null;
		try {
			String conditions = "";
			if (categoryId > -1) {
				if (conditions == "")
					conditions += " where ";
				conditions += "categoryid = :categoryid";
			}
			if (brandId > -1) {
				if (conditions == "")
					conditions += " where ";
				else
					conditions += " and ";
				conditions += "brandid = :brandid";
			}

			session = factory.openSession();
			Query<Shoe> query = session.createQuery("FROM Shoe" + conditions, Shoe.class);
			if (categoryId > -1)
				query.setParameter("categoryid", categoryId);
			if (brandId > -1)
				query.setParameter("brandid", brandId);

			List<Shoe> shoes = query.list();
			return shoes;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (session != null && session.isOpen())
					session.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public List<Shoe> getShoes() {
		return getQueryList(Shoe.class);
	}

	public List<Shoe> getShoes(int maxRows, boolean randomOrder) {
		return getQueryList(Shoe.class, maxRows, randomOrder);
	}

	public Shoe getShoe(int id) {
		return getEntityById(Shoe.class, id);
	}

	public void addShoe(Shoe shoe) {
		add(shoe);
	}

	public boolean deleteShoe(Shoe shoe) {
		return delete(shoe);
	}

	public boolean deleteShoe(int id) {
		Shoe shoe = getShoe(id);
		return delete(shoe);
	}

	public void updateShoe(Shoe shoe) {
		update(shoe);
	}

	//
	// Purchases
	//

	public List<Purchase> filterPurchases(int categoryFilter, String dateFilter) {
		Session session = null;
		try {
			String conditions = "";
			if (categoryFilter > -1) {
				if (conditions == "")
					conditions += " where ";
				conditions += "categoryid = :categoryid";
			}
			if (dateFilter != null && !dateFilter.equals("")) {
				if (conditions == "")
					conditions += " where ";
				else
					conditions += " and ";
				conditions += "day(purchase_date) = day(:purchase_date) AND month(purchase_date) = month(:purchase_date) AND year(purchase_date) = year(:purchase_date)";
			}

			session = factory.openSession();
			Query<Purchase> query = session.createQuery("FROM Purchase" + conditions, Purchase.class);
			if (categoryFilter > -1)
				query.setParameter("categoryid", categoryFilter);
			if (dateFilter != null && !dateFilter.equals(""))
				query.setParameter("purchase_date", dateFilter);

			List<Purchase> purchases = query.list();
			return purchases;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (session != null && session.isOpen())
					session.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public List<Purchase> getPurchases() {
		return getQueryList(Purchase.class);
	}

	public List<Purchase> getPurchases(String username) {
		if (username == null || username == "")
			return getQueryList(Purchase.class);
		else {
			Session session = factory.openSession();
			Query<Purchase> query = session.createQuery("FROM Purchase where username = :username", Purchase.class);
			query.setParameter("username", username);
			return query.list();
		}
	}

	public Purchase getPurchase(int id) {
		return getEntityById(Purchase.class, id);
	}

	public void insertPurchase(Purchase purchase) {
		add(purchase);
	}

	public void cancelPurchase(Purchase purchase) {
		update(purchase);
	}

	//
	// Brands
	//

	public List<Brand> getBrands() {
		return getQueryList(Brand.class);
	}

	public Brand getBrand(int id) {
		return getEntityById(Brand.class, id);
	}

	public void addBrand(Brand brand) {
		add(brand);
	}

	public boolean deleteBrand(Brand brand) {
		return delete(brand);
	}

	public boolean deleteBrand(int id) {
		Brand brand = getBrand(id);
		return delete(brand);
	}

	public void updateBrand(Brand brand) {
		update(brand);
	}

	//
	// Categories
	//

	public List<Category> getCategories()
	{
		return getQueryList(Category.class);
	}

	public Category getCategory(int id)
	{
		return getEntityById(Category.class, id);
	}
	
	public Category getCategoryByName(String name) {
		return getEntityByName(Category.class, name);
	}
	
	public void addCategory(Category category)
	{
		add(category);
	}
	
	public boolean deleteCategory(int id)
	{
		Category category = getCategory(id);
		return delete(category);
	}
	
	public boolean deleteCategory(Category category)
	{
		return delete(category);
	}
	
	public void updateCategory(Category category)
	{
		update(category);
	}

	//
	// Generic operations
	//

	private <T> T getEntityById(Class<T> entityClass, int id) {
		Session session = factory.openSession();
		T entity = session.get(entityClass, id);
		session.close();
		return entity;
	}

	private <T> T getEntityByName(Class<T> entityClass, String name) {
		Session session = factory.openSession();
		Query<T> query = session.createQuery("FROM " + entityClass.getSimpleName() + " WHERE name=:name", entityClass);
		query.setParameter("name", name);
		T airline = query.getSingleResult();
		session.close();
		return airline;
	}

	private <T> List<T> getQueryList(Class<T> entityClass) {
		return getQueryList(entityClass, -1, false);
	}

	private <T> List<T> getQueryList(Class<T> entityClass, int maxRows) {
		return getQueryList(entityClass, maxRows, false);
	}

	private <T> List<T> getQueryList(Class<T> entityClass, int maxRows, boolean randomOrder) {
		Session session = factory.openSession();
		String sql = "FROM " + entityClass.getSimpleName();
		if(randomOrder)
			sql += " ORDER BY RAND()";
		Query<T> query = session.createQuery(sql, entityClass);
		if (maxRows > 0)
			query.setMaxResults(maxRows);
		List<T> list = query.list();
		session.close();
		return list;
	}

	private void add(Object obj) {
		Session session = factory.openSession();
		Transaction tx = session.beginTransaction();
		session.save(obj);
		tx.commit();
		session.close();
	}

	private boolean delete(Object obj) {
		try {
			Session session = factory.openSession();
			Transaction tx = session.beginTransaction();
			session.delete(obj);
			tx.commit();
			session.close();

			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	private void update(Object obj) {
		Session session = factory.openSession();
		Transaction tx = session.beginTransaction();
		session.update(obj);
		tx.commit();
		session.close();
	}
}
