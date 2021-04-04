package com.example.maconarioutlinemvc.controller;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.maconarioutlinemvc.dao.AdminDao;
import com.example.maconarioutlinemvc.dao.OutlineDao;
import com.example.maconarioutlinemvc.dao.RelationDao;
import com.example.maconarioutlinemvc.dao.ScheduleDao;
import com.example.maconarioutlinemvc.domain.Admin;
import com.example.maconarioutlinemvc.domain.Outline;
import com.example.maconarioutlinemvc.domain.Relation;
import com.example.maconarioutlinemvc.domain.Schedule;

@Controller
public class AuthController {

	@Autowired
	private AdminDao adminDao;

	@Autowired
	private OutlineDao outlineDao;

	@Autowired
	private RelationDao relationDao;

	@Autowired
	private ScheduleDao scheduleDao;

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginGet(Model model) {
		model.addAttribute("admin", new Admin());
		return "login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginPost(@Valid Admin admin, Errors errors,
			Model model, HttpSession session) throws Exception {
		if (!errors.hasErrors()) {
			admin = adminDao.findByLoginIdAndLoginPass(
					admin.getLoginId(), admin.getLoginPass());
			if (admin != null) {
				session.setAttribute("loginId", admin.getLoginId());
				return "redirect:/outline";
			} else {
				model.addAttribute("admin", new Admin());
				errors.reject("error.login");
				model.addAttribute("loginError", "ログインIDかパスワードが間違っています");
				return "login";
			}
		} else {
			model.addAttribute("admin", new Admin());
			model.addAttribute("loginError", "ログインIDかパスワードが間違っています");
			return "login";
		}
	}

	@RequestMapping(value = "/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "logoutDone";
	}

	@RequestMapping(value = "/addadmin",method = RequestMethod.GET)
	public String adminAddGet (Model model) throws Exception {
		model.addAttribute("admin",new Admin());
		return "addAdmin";
	}

	@RequestMapping(value = "/addadmin",method = RequestMethod.POST)
	public String adminAddPost (@Valid Admin admin, Errors errors, Model model,
			HttpSession session) throws Exception {
		if(!errors.hasErrors()) {
			List<Admin> adminList = adminDao.findAll();
			for(Admin a:adminList) {
				if(admin.getLoginId().equals(a.getLoginId())) {
					model.addAttribute("admin",new Admin());
					model.addAttribute("loginIdDuplicateError", "入力されたログインIDはすでに使用されています");
					return "addAdmin";
				}
			}
			String pass = BCrypt.hashpw(admin.getLoginPass(),BCrypt.gensalt());
			admin.setLoginPass(pass);
			adminDao.insert(admin);
		return "addAdminDone";
		} else {
			errors.reject("error.admin");
			model.addAttribute("admin",new Admin());

			if(!admin.getLoginId().matches("[a-z0-9]{4}")) {
				model.addAttribute("loginIdError", "入力された値はログインIDに使用出来ません");
			}

			if(!admin.getLoginPass().matches("[a-z0-9]{4}")) {
				model.addAttribute("loginPassError", "入力された値はパスワードに使用出来ません");
			}

			return "addAdmin";
		}
	}

	@RequestMapping(value = "/deleteadmin", method = RequestMethod.GET)
	public String deleteAdminGet (Model model) throws Exception {
		model.addAttribute("admin",new Admin());
		return "deleteAdmin";
	}

	@RequestMapping(value = "/deleteadmin", method = RequestMethod.POST)
	public String deleteAdminPost (@Valid Admin admin, Errors errors, Model model,
			HttpSession session, Outline outline, Schedule schedule) throws Exception {
		if (!errors.hasErrors()) {
			admin = adminDao.findByLoginIdAndLoginPass(
					admin.getLoginId(), admin.getLoginPass());
			if (admin != null) {
				List<Relation> relationList = new ArrayList<>();
				relationList = relationDao.findByAdmin(admin.getId());
				if(relationList.isEmpty()) {
					adminDao.delete(admin);
					return "deleteAdminDone";
				} else {
					Set<Integer> linkedHashOutline = new LinkedHashSet<>();
					Set<Integer> linkedHashSchedule = new LinkedHashSet<>();

					for (Relation r :relationList) {
						linkedHashOutline.add(r.getOutlineId());
						if (r.getScheduleId()!=null) {
						linkedHashSchedule.add(r.getScheduleId());
						}
					}

					for(Relation r:relationList) {
						relationDao.delete(r);
					}

					for(Integer id :linkedHashOutline) {
						outline = outlineDao.findById(id);
						outlineDao.delete(outline);
					}

					for(Integer id :linkedHashSchedule) {
						schedule = scheduleDao.findById(id);
						scheduleDao.delete(schedule);
					}

					adminDao.delete(admin);
					return "deleteAdminDone";
				}
			} else {
				model.addAttribute("admin", new Admin());
				errors.reject("error.login");
				model.addAttribute("loginError", "ログインIDかパスワードが間違っています");
				return "deleteAdmin";
			}
		} else {
			model.addAttribute("admin", new Admin());
			model.addAttribute("loginError", "ログインIDかパスワードが間違っています");
			return "deleteAdmin";
		}
	}
}
