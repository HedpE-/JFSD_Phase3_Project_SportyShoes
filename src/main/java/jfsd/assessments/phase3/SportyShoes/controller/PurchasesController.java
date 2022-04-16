package jfsd.assessments.phase3.SportyShoes.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jfsd.assessments.phase3.SportyShoes.entity.Purchase;
import jfsd.assessments.phase3.SportyShoes.entity.Shoe;
import jfsd.assessments.phase3.SportyShoes.entity.User;
import jfsd.assessments.phase3.SportyShoes.util.CrudHelper;

@Controller
public class PurchasesController {

	@Autowired
	private CrudHelper crudHelper;
	
	@GetMapping("/buy")
	public String getBuyShoe(@RequestParam int id, Map<String, Object> map, HttpSession session) {
		Object user = session.getAttribute("user");
		if(user == null) {
			map.put("redirect", "buy?id=" + id);
			return "redirect:signin";
		}
		map.put("shoe", crudHelper.getShoe(id));
		return "checkout";
	}
	
	@PostMapping("/buy")
	public String processPurchase(Purchase purchase, String cc_number) {
		purchase.setPayment_method("credit");
		purchase.setCc_lastdigits(cc_number.substring(cc_number.length() - 4));
		crudHelper.insertPurchase(purchase);
		return "congrats";
	}
	
	@GetMapping("/purchases")
	public String getPurchases(@RequestParam(required = false) String username,
			Map<String, Object> map, HttpSession session) {
		List<Purchase> purchases;
		if(username == null || username.equals("")) {
			User user = (User)session.getAttribute("user");
			purchases = crudHelper.getPurchases(user.getUsername());
		}
		else
			purchases = crudHelper.getPurchases(username);
		map.put("purchasesResult", purchases);
		
		return "purchaseHistory";
	}
	
	@GetMapping("/purchaseDetails")
	public String getpurchaseDetails(@RequestParam int id,
			@RequestParam String redirect,
			Map<String, Object> map) {
		map.put("purchase", crudHelper.getPurchase(id));
		if (redirect != null && !redirect.equals(""))
			map.put("redirect", redirect);
		return "purchaseDetails";
	}
}
