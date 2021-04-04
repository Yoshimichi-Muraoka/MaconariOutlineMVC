<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.sql.Date"%>
<%@ page import="com.example.maconarioutlinemvc.domain.Schedule"%>
<%@ page import="java.util.List"%>

<%
	request.setCharacterEncoding("UTF-8");
	List<Schedule> scheduleList = (List<Schedule>) request.getAttribute("scheduleList");
	Calendar calendar = Calendar.getInstance();
	int year = calendar.get(Calendar.YEAR);
	int month = calendar.get(Calendar.MONTH);
	String reqyear = request.getParameter("year");
	String reqmonth = request.getParameter("month");
	if (reqyear != null && reqmonth != null) {
		if (!reqyear.isEmpty() && !reqmonth.isEmpty()) {
			year = Integer.parseInt(reqyear);
			month = Integer.parseInt(reqmonth);
			month--;
		}
	}
	int nextMonth = month + 1;
	calendar.set(year, nextMonth, 0);
	int lastDate = calendar.get(Calendar.DATE);
	calendar.set(year, month, 1);
	int week = calendar.get(Calendar.DAY_OF_WEEK);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link href="<c:url value="/resources/css/calendar.css" />" type="text/css" rel="stylesheet"/>
<title>達成計画カレンダー</title>
</head>
<body>
<header class="header container-fulid">
	<div class="header__inner row h-50 align-items-center">
		<h2 class="header__logo col-5 offset-1">達成計画カレンダー</h2>
	</div>
	<div class="header__inner row h-50 align-items-center">
		<div class="header__form col-3 offset-1">
			<form action="">
				<select name="year">
					<option value="">-</option>
					<option value="2020">2020</option>
					<option value="2021">2021</option>
					<option value="2022">2022</option>
					<option value="2023">2023</option>
					<option value="2024">2024</option>
					<option value="2025">2025</option>
					<option value="2026">2026</option>
					<option value="2027">2027</option>
					<option value="2028">2028</option>
					<option value="2029">2029</option>
					<option value="2030">2030</option>
				</select> 年
				<select name="month">
					<option value="">-</option>
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
					<option value="12">12</option>
				</select> 月
				<button type="submit" class="btn btn-primary btn-sm">カレンダーを表示する</button>
			</form>
		</div>
			<p class="header__goback col-2 offset-5">
				<a href="<spring:url value= "/outline" />">アウトライン一覧へ戻る</a>
			</p>
	</div>
</header>
<div class="container">
	<div class="container__inner row align-items-center mt-4">
		<p class="inner-item__date col-3"><%=year%>年 <%=nextMonth%>月</p>
		<p class="inner-item__message col-6">カレンダーのアイコンをクリックしてスケジュールを登録して下さい</p>
		<table class="table table-striped" border="1">
			<tr class="table__week">
				<th class="table__week_sunday">日</th>
				<th>月</th>
				<th>火</th>
				<th>水</th>
				<th>木</th>
				<th>金</th>
				<th class="table__week_suturday">土</th>
			</tr>
			<tr class="table__day">
				<%
					for (int i = 1; i < week; i++) {
				%>
				<td></td>
				<%
					}
				%>
	<%
		for (int i = 1; i <= lastDate; i++) {
				int date = calendar.get(Calendar.DATE);
	%>
				<td class="table__day_date"><%=date%>
					<div class="table__day_icon">
						<a href="schedule?year=<%=year%>&month=<%=nextMonth%>&date=<%=date%>"><img
							src="<c:url value="/resources/image/scheduleregistration.png"/>"
							alt="アイコンをクリックしてスケジュールを表示して下さい" /></a>
					</div> <%
	 		String calendarDate = year + "-" + nextMonth + "-" + date;
	 		for (Schedule schedule : scheduleList) {
	 			String scheduleStr = schedule.getSchedule();
	 			Date scheduleSqlDate = schedule.getScheduledate();
	 			String scheduleDate = scheduleSqlDate.toString();
	 			if (scheduleDate.startsWith("0", 8)) {
	 				StringBuilder sb = new StringBuilder(scheduleDate);
	 				sb.delete(8, 9);
	 				scheduleDate = sb.toString();
	 			}
	 			if (scheduleDate.startsWith("0", 5)) {
	 				StringBuilder sb = new StringBuilder(scheduleDate);
	 				sb.delete(5, 6);
	 				scheduleDate = sb.toString();
	 			}
	 			if (calendarDate.equals(scheduleDate)) {
	 %>
					<p class="table__day_schedule">・<%=scheduleStr%></p> <%
	 			}
	 		}
	 %></td>
				<%
					if (Calendar.SATURDAY == calendar.get(Calendar.DAY_OF_WEEK)) {
				%>
			<tr class="table__day_kaigyou"></tr>
			<%
				}
			%>
			<%
				calendar.add(Calendar.DATE, 1);
		}
			%>
			<%
				for (; lastDate < 31; lastDate++) {
			%>
			<td></td>
			<%
				}
			%>
			</tr>
		</table>
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>