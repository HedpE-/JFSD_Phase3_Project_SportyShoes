package jfsd.assessments.phase3.SportyShoes.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity(name="Category")
@Table(name="categories")
public class Category {
	
	@Id
	@Column(nullable = false, unique = true, insertable = false, updatable = false)
	private int id;
	@Column(nullable = false)
	private String name;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
