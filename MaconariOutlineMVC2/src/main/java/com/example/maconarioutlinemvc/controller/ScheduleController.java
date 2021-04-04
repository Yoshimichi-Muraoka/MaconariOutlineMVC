package com.example.maconarioutlinemvc.controller;

import java.sql.Date;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.maconarioutlinemvc.dao.AdminDao;
import com.example.maconarioutlinemvc.dao.RelationDao;
import com.example.maconarioutlinemvc.dao.ScheduleDao;
import com.example.maconarioutlinemvc.domain.Admin;
import com.example.maconarioutlinemvc.domain.Relation;
import com.example.maconarioutlinemvc.domain.Schedule;

@Controller
public class ScheduleController {

	@Autowired
	private AdminDao adminDao;

	@Autowired
	private ScheduleDao scheduleDao;

	@Autowired
	private RelationDao relationDao;

	@RequestMapping(value = "/calendar/{outlineId}", method = RequestMethod.GET)
	public void calendar(Model model, @PathVariable("outlineId") Integer outlineId,
			HttpServletRequest request, HttpServletResponse response,
			HttpSession session ) throws Exception {
		List<Relation> relationList = relationDao.findByRelation(outlineId);
		List<Schedule> scheduleList = new ArrayList<>();
		for (Relation r : relationList) {
			if (r.getScheduleId() != null) {
				scheduleList.add(scheduleDao.findById(r.getScheduleId()));
			}
		}
		request.setAttribute("scheduleList", scheduleList);
		session.setAttribute("outlineId", outlineId);
		request.getRequestDispatcher("/WEB-INF/views/calendar.jsp")
				.forward(request, response);
	}

	@RequestMapping(value = "/calendar/schedule", method = RequestMethod.GET)
	public void schedule(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession session) throws Exception {
		Integer outlineId = (Integer) session.getAttribute("outlineId");
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String date = request.getParameter("date");

		if(year!=null && month!=null && date!=null) {
			session.setAttribute("year", year);
			session.setAttribute("month", month);
			session.setAttribute("date", date);
		}

		List<Relation> relationList = relationDao.findByRelation(outlineId);
		List<Schedule> scheduleList = new ArrayList<>();
		for (Relation r : relationList) {
			if (r.getScheduleId() != null) {
				scheduleList.add(scheduleDao.findById(r.getScheduleId()));
			}
		}
		request.setAttribute("scheduleList", scheduleList);
		request.getRequestDispatcher("/WEB-INF/views/schedule.jsp")
				.forward(request, response);
	}

	@RequestMapping(value = "/calendar/schedule", method = RequestMethod.POST)
	public String scheduleAdd( Model model, HttpServletRequest request, HttpSession session,
			Admin admin, Schedule schedule, Relation relation,
			@RequestParam("registrationdateyear") String year,
			@RequestParam("registrationdatemonth") String month,
			@RequestParam("registrationdateday") String date,
			@RequestParam("registrationtimestarthour") String starthour,
			@RequestParam("registrationtimestartminutes") String startminutes,
			@RequestParam("registrationtimeendhour") String endhour,
			@RequestParam("registrationtimeendminutes") String endminutes,
			@RequestParam("schedule") String schedulestr,
			@RequestParam("memo") String memo) throws Exception {
		String loginId = (String)session.getAttribute("loginId");
		admin = adminDao.findByLoginId(loginId);
		Integer outlineId = (Integer) session.getAttribute("outlineId");
		List<Relation> relationList = relationDao.findByRelation(outlineId);
		List<Schedule> scheduleList = new ArrayList<>();
		for (Relation r : relationList) {
			if (r.getScheduleId() != null) {
				scheduleList.add(scheduleDao.findById(r.getScheduleId()));
			}
		}
		request.setAttribute("scheduleList", scheduleList);
		boolean isError = false;
		String scheduledatestr = year + "-" + month + "-" + date;
		Date scheduledate = Date.valueOf(scheduledatestr);
		String starttimestr = starthour + ":" + startminutes+":00";
		String endtimestr = endhour + ":" + endminutes+":00";

		if(schedulestr.isEmpty()) {
			isError=true;
			request.setAttribute("scheduleError", "予定が入力されていません");
		}

		try {
			LocalTime localStart = LocalTime.parse(starttimestr);
			LocalTime localEnd = LocalTime.parse(endtimestr);
			if(localStart.equals(localEnd)||localStart.isAfter(localEnd)) {
				isError=true;
				request.setAttribute("scheduleTimeError", "時間を正しく設定してください");
			}
		}catch(Exception e) {
			isError=true;
			request.setAttribute("scheduleTimeParseError", "時間が入力されていません");
		}

		request.setAttribute("schedulestr", schedulestr);
		request.setAttribute("memo", memo);

		if(!isError) {
			schedule.setSchedule(schedulestr);
			schedule.setMemo(memo);
			schedule.setScheduledate(scheduledate);
			Time starttime = Time.valueOf(starttimestr);
			schedule.setStarttime(starttime);
			Time endtime = Time.valueOf(endtimestr);
			schedule.setEndtime(endtime);
			scheduleDao.insert(schedule);
			List<Schedule> scheduleListAll = scheduleDao.findAll();
			int lastIndex = scheduleListAll.size()-1;
			schedule = scheduleListAll.get(lastIndex);
			int scheduleId = schedule.getId();
			relation.setAdminId(admin.getId());
			relation.setOutlineId(outlineId);
			relation.setScheduleId(scheduleId);
			relationDao.insert(relation);

			return "scheduleDone";
		} else {
			return "schedule";
		}

	}

	@RequestMapping(value = "/calendar/scheduleedit", method = RequestMethod.GET)
	public void scheduleEditGet(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Schedule schedule,
			Integer scheduleId) throws Exception {
		String scheduleIdStr = request.getParameter("scheduleId");
		if(scheduleIdStr!=null) {
			scheduleId = Integer.parseInt(scheduleIdStr);
			session.setAttribute("scheduleId", scheduleId);
		}else {
			scheduleId=(Integer)session.getAttribute("scheduleId");
		}
		schedule = scheduleDao.findById(scheduleId);
		request.setAttribute("schedule", schedule);
		request.getRequestDispatcher("/WEB-INF/views/scheduleEdit.jsp")
				.forward(request, response);
	}

	@RequestMapping(value = "/calendar/scheduleedit", method = RequestMethod.POST)
	public void scheduleEditPost(Model model, HttpServletRequest request, HttpServletResponse response,
			HttpSession session, Schedule schedule,
			@RequestParam("registrationdateyear") String yearStr,
			@RequestParam("registrationdatemonth") String monthStr,
			@RequestParam("registrationdateday") String dateStr,
			@RequestParam("registrationtimestarthour") String starthourStr,
			@RequestParam("registrationtimestartminutes") String startminutesStr,
			@RequestParam("registrationtimeendhour") String endhourStr,
			@RequestParam("registrationtimeendminutes") String endminutesStr,
			@RequestParam("schedule") String scheduleStr,
			@RequestParam("memo") String memo) throws Exception {
		Integer scheduleId = (Integer) session.getAttribute("scheduleId");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String scheduleDateStr = yearStr + "-" + monthStr + "-" + dateStr;
		sdf.setLenient(false);
		java.util.Date date = new java.util.Date();
		boolean isError = false;
		String starttimestr = starthourStr + ":" + startminutesStr + ":" + 0 + 0;
		Time starttime = Time.valueOf(starttimestr);
		LocalTime localStart = starttime.toLocalTime();
		String endtimestr = endhourStr + ":" + endminutesStr + ":" + 0 + 0;
		Time endtime = Time.valueOf(endtimestr);
		LocalTime localEnd = endtime.toLocalTime();

		schedule = scheduleDao.findById(scheduleId);

		if(scheduleStr.isEmpty()) {
			isError=true;
			request.setAttribute("scheduleError", "予定が入力されていません");
		}

		try {
			date = sdf.parse(scheduleDateStr);
		} catch (ParseException e) {
			isError = true;
			request.setAttribute("dateError", "入力した日付けは存在しません");
		}

		if(localStart.equals(localEnd)||localStart.isAfter(localEnd)) {
			isError=true;
			request.setAttribute("scheduleTimeError", "時間を正しく設定してください");
		}

		if (!isError) {
			schedule.setSchedule(scheduleStr);
			schedule.setMemo(memo);
			java.sql.Date scheduledate = new java.sql.Date(date.getTime());
			schedule.setScheduledate(scheduledate);
			schedule.setStarttime(starttime);
			schedule.setEndtime(endtime);
			request.setAttribute("schedule", schedule);
			scheduleDao.update(schedule);
			request.getRequestDispatcher("/WEB-INF/views/scheduleEditDone.jsp")
					.forward(request, response);
		} else {
			request.setAttribute("schedule", schedule);
			request.getRequestDispatcher("/WEB-INF/views/scheduleEdit.jsp")
					.forward(request, response);
		}
	}

	@RequestMapping(value = "/calendar/scheduleDelete/{scheduleId}")
	public String scheduleDelete(Model model, HttpSession session,
			@PathVariable("scheduleId") Integer scheduleId,
			Relation relation,
			Schedule schedule) throws Exception {
		relation = relationDao.findBySchedule(scheduleId);
		relation.setScheduleId(null);
		relationDao.update(relation);

		schedule.setId(scheduleId);
		scheduleDao.delete(schedule);
		return "scheduleDeleteDone";
	}
}
