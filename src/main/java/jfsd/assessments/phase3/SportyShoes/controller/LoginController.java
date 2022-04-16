package jfsd.assessments.phase3.SportyShoes.controller;

import java.io.IOException;
import java.util.Date;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.persistence.PersistenceException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jfsd.assessments.phase3.SportyShoes.entity.User;
import jfsd.assessments.phase3.SportyShoes.util.CrudHelper;

@Controller
public class LoginController {

	@Autowired
	private CrudHelper crudHelper;

	@GetMapping("/signin")
	public String signInUser(@RequestParam(required = false) String error,
			@RequestParam(required = false) String redirect,
			Map<String, String> map) {
		if (error != null && !error.equals(""))
			map.put("error", error);
		if (redirect != null && !redirect.equals(""))
			map.put("redirect", redirect);
		return "login";
	}

	@GetMapping("/home")
	public String goHome() {
		return "index";
	}

	@PostMapping("/login")
	public String loginUser(@RequestParam(required = false) String redirect,
			User user, Map<String, String> map, HttpSession session) {
		User dbUser = crudHelper.getUser(user.getUsername());

		if (user.validateUser(dbUser)) {
			dbUser.setLast_login(new Date());
			crudHelper.updateUser(dbUser);
			session.setAttribute("user", dbUser);
			
			if(redirect != null && !redirect.equals(""))
				return "redirect:" + redirect;
			
			return "redirect:home";
		}

		map.put("error", "Invalid Credentials");		
		if(redirect != null && !redirect.equals(""))
			map.put("redirect", redirect);		
		return "redirect:signin";
	}

	@GetMapping("/register")
	public String register(@RequestParam(required = false) String error,
			@RequestParam(required = false) String redirect,
			Map<String, String> map) {
		if (error != null && !error.equals(""))
			map.put("error", error);
		if (redirect != null && !redirect.equals(""))
			map.put("redirect", redirect);
		return "register";
	}

	@PostMapping("/register")
	public String registerUser(@RequestParam(required = false) String redirect,
			User user, String rpassword, boolean admin_request,
			Map<String, String> map,
			HttpSession session) throws IOException {
		final String regex = "^(.+)@(.+)\\.(.+)$";

		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(user.getEmail());
		if (matcher.matches()) {
			if (user.validatePassword(rpassword)) {
				try {
					user.setRole(admin_request ? "admin" : "customer");
					crudHelper.registerUser(user);
					if(redirect != null && !redirect.equals("")) {
						map.put("redirect", redirect);
						return "redirect:signin";
					}
					
					return "redirect:home";
				}
				catch (PersistenceException e) {
					e.printStackTrace();
					String msg = e.getCause().getCause().getMessage();
					if(msg.startsWith("Duplicate entry")) {
						if(msg.contains("users.email"))
							msg = "Email already registered";
						else
							msg = "Username already in use";
					}
					map.put("error", msg);
				}
			}
			else
				map.put("error", "Passwords must match");
		}
		else
			map.put("error", "Invalid Email");
		
		if (redirect != null && !redirect.equals(""))
			map.put("redirect", redirect);

		return "redirect:register";
	}

	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("email");
		session.invalidate();
		return "redirect:home";
	}

}
