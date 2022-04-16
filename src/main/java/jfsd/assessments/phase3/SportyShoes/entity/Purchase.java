package jfsd.assessments.phase3.SportyShoes.entity;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity(name = "Purchase")
@Table(name = "purchases")
public class Purchase {

	@Id
	@Column(nullable = false, unique = true, insertable = false, updatable = false)
	private int id;
	@Column(nullable = false)
	private String username;
	@ManyToOne
	@JoinColumn(name = "username", referencedColumnName = "username", insertable=false, updatable=false)
	private User user;
	@Column(nullable = false)
	private int shoeid;
	@ManyToOne
	@JoinColumn(name = "shoeid", referencedColumnName = "id", insertable = false, updatable = false)
	private Shoe shoe;
	@Column(nullable = false)
	private int categoryid;
	@ManyToOne
	@JoinColumn(name = "categoryid", referencedColumnName = "id", insertable = false, updatable = false)
	private Category category;
	@Temporal(TemporalType.TIMESTAMP)
	@Column(columnDefinition = "utc_timestamp()", nullable = false, insertable = false, updatable = false)
	private Date purchase_date;
	@Column(nullable = false)
	private int quantity;
	@Column(nullable = false)
	private String address;
	private String address2;
	@Column(nullable = false)
	private String country;
	@Column(nullable = false)
	private String city;
	@Column(nullable = false)
	private String postcode;
	@Column(nullable = false)
	private String payment_method;
	@Column(nullable = false)
	private String cc_lastdigits;
	@Column(nullable = false)
	private float total_ammount;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public User getUser() {
		return user;
	}

	public int getShoeid() {
		return shoeid;
	}

	public void setShoeid(int shoeid) {
		this.shoeid = shoeid;
	}

	public Shoe getShoe() {
		return shoe;
	}

	public int getCategoryid() {
		return categoryid;
	}

	public void setCategoryid(int categoryid) {
		this.categoryid = categoryid;
	}

	public Category getCategory() {
		return category;
	}

	public Date getPurchase_date() {
		return purchase_date;
	}

	public String getPurchase_date(String format) {
		String formatted = new SimpleDateFormat(format).format(purchase_date);
		return formatted;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getPayment_method() {
		return payment_method;
	}

	public void setPayment_method(String payment_method) {
		this.payment_method = payment_method;
	}

	public String getCc_lastdigits() {
		return cc_lastdigits;
	}

	public void setCc_lastdigits(String cc_lastdigits) {
		this.cc_lastdigits = cc_lastdigits;
	}

	public float getTotal_ammount() {
		return total_ammount;
	}

	public void setTotal_ammount(float total_ammount) {
		this.total_ammount = total_ammount;
	}
}
