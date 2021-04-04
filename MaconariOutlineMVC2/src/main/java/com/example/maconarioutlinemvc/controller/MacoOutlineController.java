package com.example.maconarioutlinemvc.controller;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
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
public class MacoOutlineController {

	@Autowired
	private AdminDao adminDao;

	@Autowired
	private OutlineDao outlineDao;

	@Autowired
	private RelationDao relationDao;

	@Autowired
	private ScheduleDao scheduleDao;

	@RequestMapping(value = "/outline")
	public String outline(Model model, HttpSession session, Admin admin,
			Relation relation ) throws Exception {
		String loginId = (String)session.getAttribute("loginId");
		admin = adminDao.findByLoginId(loginId);
		List<Relation> relationList = relationDao.findByAdmin(admin.getId());
		List<Outline> outlineList = new ArrayList<>();
		Set<Integer> linkedHash = new LinkedHashSet<>();

		for(Relation r:relationList) {
			linkedHash.add(r.getOutlineId());
		}

		for(Integer i:linkedHash) {
			outlineList.add(outlineDao.findById(i));
		}

		model.addAttribute("outlineList", outlineList);
		return "macoOutline";
	}

	@RequestMapping(value = "/outlineadd", method = RequestMethod.GET)
	public String outlineAddGet(Model model) throws Exception {
		Outline outline = new Outline();
		model.addAttribute("outline", outline);
		return "macoOutlineAdd";
	}

	@RequestMapping(value = "/outlineadd", method = RequestMethod.POST)
	public String outlineAddPost(@Valid Outline outline, Errors errors, Admin admin,
			Model model, HttpSession session) throws Exception {

		if (!errors.hasErrors()) {

			outlineDao.insert(outline);

			List<Outline> outlineList = outlineDao.findAll();
			int lastIndex = outlineList.size() - 1;
			outline = outlineList.get(lastIndex);
			int outlineId = outline.getId();
			Relation relation = new Relation();
			String loginId = (String)session.getAttribute("loginId");
			admin = adminDao.findByLoginId(loginId);
			relation.setOutlineId(outlineId);
			relation.setAdminId(admin.getId());
			relationDao.insert(relation);
			return "macoOutlineAddDone";

		} else {
			return "macoOutlineAdd";
		}
	}

	@RequestMapping(value = "/outlineedit/{id}", method = RequestMethod.GET)
	public String outlineEditGet(Model model,
			@PathVariable("id") Integer id) throws Exception {
		Outline outline = outlineDao.findById(id);
		model.addAttribute("outline", outline);
		return "macoOutlineEdit";
	}

	@RequestMapping(value = "/outlineedit/{id}", method = RequestMethod.POST)
	public String outlineEditPost(@Valid Outline outlinePost, Errors errors, Model model,
			@PathVariable("id") Integer id) throws Exception {

		if (!errors.hasErrors()) {

			outlinePost.setId(id);
			outlineDao.update(outlinePost);
			return "macoOutlineEditDone";

		} else {
			if(outlinePost.getGoal().isEmpty()) {
				model.addAttribute("goalEmptyError","ゴールが入力されていません" );
			}

			if(outlinePost.getGoal().length() > 200) {
				model.addAttribute("goalLengthError","200文字以内で入力してください" );
			}

			if(outlinePost.getGutaitekigoal().length() > 500) {
				model.addAttribute("gutaitekiGoalLengthError","500文字以内で入力してください" );
			}

			if(outlinePost.getKadai().length() > 800) {
				model.addAttribute("kadaiLengthError","800文字以内で入力してください" );
			}

			if(outlinePost.getKaiketsusaku().length() > 800) {
				model.addAttribute("kaiketsusakuLengthError","800文字以内で入力してください" );
			}

			return "macoOutlineEdit";
		}
	}

	@RequestMapping(value = "/outlinedelete/{outlineId}", method = RequestMethod.GET)
	public String outlineDelete(Model model, @PathVariable("outlineId") Integer outlineId,
			Admin admin, Outline outline, Relation relation, Schedule schedule) throws Exception {
		List<Relation> relationList = relationDao.findByRelation(outlineId);
		for (Relation r : relationList) {
			Integer relationId = r.getId();
			Integer scheduleId = r.getScheduleId();

			relation.setId(relationId);
			relationDao.delete(relation);

			schedule.setId(scheduleId);
			scheduleDao.delete(schedule);
		}
		outline.setId(outlineId);
		outlineDao.delete(outline);
		return "macoOutlineDeleteDone";
	}

	@RequestMapping(value = "/outlinesample", method = RequestMethod.GET)
	public String outlineSample(Model model) throws Exception{
		return "macoOutlineSample";
	}

}
