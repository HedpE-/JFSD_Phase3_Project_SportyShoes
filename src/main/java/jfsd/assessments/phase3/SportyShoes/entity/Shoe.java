package jfsd.assessments.phase3.SportyShoes.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity(name = "Shoe")
@Table(name = "shoes")
public class Shoe {
	@Id
	@Column(nullable = false, unique = true, insertable = false, updatable = false)
	private int id;
	@Column(nullable = false)
	private int brandid;
	@ManyToOne
	@JoinColumn(name = "brandid", referencedColumnName = "id", insertable = false, updatable = false)
	private Brand brand;
	@Column(nullable = false)
	private String model;
	@Column(name = "categoryid")
	private int categoryId;
	@OneToOne
	@JoinColumn(name = "categoryid", referencedColumnName = "id", insertable = false, updatable = false)
	private Category category;
	@Column(nullable = false)
	private double price;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getBrandid() {
		return brandid;
	}

	public void setBrandid(int brandid) {
		this.brandid = brandid;
	}

	public Brand getBrand() {
		return brand;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public Category getCategory() {
		return category;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}
}
