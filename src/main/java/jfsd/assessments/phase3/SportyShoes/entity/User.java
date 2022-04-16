package jfsd.assessments.phase3.SportyShoes.entity;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity(name = "User")
@Table(name = "users")
public class User {

	@Id
	@Column(unique = true, nullable = false, length = 10)
	private String username;
	@Column(unique = true, nullable = false)
	private String email;
	@Temporal(TemporalType.TIMESTAMP)
	@Column(columnDefinition = "utc_timestamp()", insertable = false, updatable = false)
	private Date create_time;
	@Column(nullable = false)
	private String fname;
	@Column(nullable = false)
	private String lname;
	@Column(nullable = false)
	private String password;
	@Column(nullable = false)
	private String role;
	@Temporal(TemporalType.TIMESTAMP)
	private Date last_login;
	@OneToMany
	@JoinColumn(name = "username", referencedColumnName = "username", insertable = false, updatable = false)
	private List<Purchase> purchases;

	public User() {
	}

	public User(String username, String fname, String lname, String email, String password, String role) {
		this.username = username;
		this.email = email;
		this.fname = fname;
		this.lname = lname;
		this.password = password;
		this.role = role;
	}

	public User(String username, String fname, String lname, String email, String password) {
		this(username, fname, lname, email, password, "customer");
	}

	public Date getCreate_time() {
		return create_time;
	}

	public String getCreate_time(String format) {
		String formatted = new SimpleDateFormat(format).format(create_time);
		return formatted;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}

	public String getLname() {
		return lname;
	}

	public void setLname(String lname) {
		this.lname = lname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public boolean validateUser(User user) {
		if (user == null)
			return false;
		return validatePassword(user.password);
	}

	public boolean validatePassword(String password) {
		return this.password.equals(password);
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Date getLast_login() {
		return last_login;
	}

	public String getLast_login(String format) {
		if(last_login == null)
			return "Never";
		String formatted = new SimpleDateFormat(format).format(last_login);
		return formatted;
	}

	public void setLast_login(Date last_login) {
		this.last_login = last_login;
	}

	public List<Purchase> getPurchases() {
		return purchases;
	}

	@Override
	public String toString() {
		return "LoginUser [email=" + email + ", password=" + password + "]";
	}
}
