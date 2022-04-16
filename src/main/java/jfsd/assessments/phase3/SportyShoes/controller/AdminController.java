package jfsd.assessments.phase3.SportyShoes.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jfsd.assessments.phase3.SportyShoes.entity.Brand;
import jfsd.assessments.phase3.SportyShoes.entity.Category;
import jfsd.assessments.phase3.SportyShoes.entity.Shoe;
import jfsd.assessments.phase3.SportyShoes.entity.User;
import jfsd.assessments.phase3.SportyShoes.util.CrudHelper;

@Controller
public class AdminController {

	@Autowired
	private CrudHelper crudHelper;
	
	@PostMapping("/changePassword")
	public String changePassword(@RequestParam String username,
			@RequestParam String password,
			@RequestParam String rpassword,
			Map<String, String> map,
			HttpSession session) {
		if(password.equals(rpassword)) {
			User user = crudHelper.getUser(username);
			if(user.validatePassword(rpassword)) {
				map.put("error", "Same password entered");
			}
			else {
				user.setPassword(rpassword);
				crudHelper.updateUser(user);
				session.setAttribute("user", user);

				map.put("success", "Password has been changed");
			}
		}
		else
			map.put("error", "Passwords must match");
		
		return "redirect:home";
	}
	
	@GetMapping("/adminMasterlist")
	public String showMasterlist(@RequestParam String view,
			@RequestParam(required = false) String username,
			Map<String, Object> map) {
		String paramName = "viewContext";
		switch(view) {
			case "shoes":
				map.put("view", view);
				map.put(paramName, crudHelper.getShoes());
				break;
			case "brands":
				map.put("view", view);
				map.put(paramName, crudHelper.getBrands());
				break;
			case "categories":
				map.put("view", view);
				map.put(paramName, crudHelper.getCategories());
				break;
			case "purchases":
				map.put(paramName, crudHelper.getPurchases(username));
				break;
			case "users":
				map.put("view", view);
				map.put(paramName, crudHelper.getUsersByLastLogin());
				break;
		}
		
		if(view.equals("purchases"))
			return "purchasesMasterlist";
		
		return "adminMasterlist";
	}
	
	@PostMapping("/purchasesMasterlist")
	public String filterPurchases(@RequestParam int categoryFilter,
			@RequestParam(required = false) String dateFilter,
			Map<String, Object> map) {
		Date date = null;
		try {
			date = new SimpleDateFormat("yyyy-MM-dd").parse(dateFilter);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		map.put("viewContext", crudHelper.getPurchases(categoryFilter, dateFilter));
		
		return "purchasesMasterlist";
	}
	
	@PostMapping("/addShoe")
	public String addEntity(Shoe shoe, Map<String, String> map) {
		crudHelper.addShoe(shoe);

		map.put("view", "shoes");
		map.put("success", "Shoe entity added");
		return "redirect:adminMasterlist";
	}
	
	@PostMapping("/addBrand")
	public String addEntity(Brand brand, Map<String, String> map) {
		crudHelper.addBrand(brand);

		map.put("view", "brands");
		map.put("success", "Brand entity added");
		return "redirect:adminMasterlist";
	}
	
	@PostMapping("/addCategory")
	public String addEntity(Category category, Map<String, String> map) {
		crudHelper.addCategory(category);

		map.put("view", "categories");
		map.put("success", "Category entity added");
		return "redirect:adminMasterlist";
	}
	
	@GetMapping("/delete")
	public String deleteEntity(@RequestParam String view,
			@RequestParam(required = false) int id,
			@RequestParam(required = false) String username,
			Map<String, String> map) {
		map.put("view", view);
		switch(view) {
			case "brands":
				crudHelper.deleteBrand(id);
				map.put("success", "Brand entity deleted");
				break;
			case "categories":
				crudHelper.deleteCategory(id);
				map.put("success", "Category entity deleted");
				break;
			case "shoes":
				crudHelper.deleteShoe(id);
				map.put("success", "Shoe entity deleted");
				break;
			case "users":
				crudHelper.deleteUser(username);
				map.put("success", "User account deleted");
				break;
			default:
				map.put("error", "Unknown entity type");
				break;
		}

		return "redirect:adminMasterlist";
	}
}
