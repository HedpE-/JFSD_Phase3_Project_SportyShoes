package jfsd.assessments.phase3.SportyShoes.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jfsd.assessments.phase3.SportyShoes.entity.Shoe;
import jfsd.assessments.phase3.SportyShoes.util.CrudHelper;

@Controller
public class ProductsController {

	@Autowired
	private CrudHelper crudHelper;
	
	@GetMapping("/products")
	public String getProducts(@RequestParam(required = false, defaultValue = "-1") int category,
			@RequestParam(required = false, defaultValue = "-1") int brand,
			Map<String, Object> map, HttpSession session) {
		
		List<Shoe> shoes = crudHelper.getShoes(category, brand);
		map.put("shoesResult", shoes);
		
		return "products";
	}
}
