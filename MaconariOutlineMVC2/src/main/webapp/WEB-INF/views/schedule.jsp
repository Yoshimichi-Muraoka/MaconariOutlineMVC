<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.sql.Time"%>
<%@ page import="com.example.maconarioutlinemvc.domain.Schedule"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.LocalTime"%>
<%@ page import="java.time.LocalDate"%>

<%
	String yearStr = (String)session.getAttribute("year");
	String monthStr = (String)session.getAttribute("month");
	String dateSessionStr = (String)session.getAttribute("date");
	Integer year = Integer.parseInt(yearStr);
	Integer month = Integer.parseInt(monthStr);
	Integer date = Integer.parseInt(dateSessionStr);
	String dateStr = year + "-" + month + "-" + date;
	LocalTime scheduleTime = LocalTime.of(0, 0);

	List<Schedule> scheduleList = (List<Schedule>) request.getAttribute("scheduleList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link href="<c:url value="/resources/css/schedule.css" />" type="text/css" rel="stylesheet"/>
<title>スケジュール登録ページ</title>
</head>
<body>
<header class="header container-fluid">
	<div class="header__inner row h-100 align-items-center">
		<h2 class="header__logo col-5 offset-1">スケジュール登録</h2>
		<p class="header__goback col-2 offset-1"><a class="header__goback_link" href="/maconarioutlinemvc/calendar/<c:out value="${outlineId}"/>">達成計画カレンダーへ戻る</a></p>
		<p class="header__goback col-2"><a class="header__goback_link" href="<spring:url value= "/outline" />">アウトライン一覧へ戻る</a></p>
	</div>
</header>
<div class="main container mt-4 mb-4">
	<div class="main__inner row">
		<div class="schedule col-md-6">
			<table border="1">
				<tr>
					<th class="table__th_time">時刻</th>
					<th class="table__th_schedule">予定</th>
				</tr>
				<%
					for (int i = 0; i < 24; i++) {
				%>
				<tr class="table__tr">
					<td class="table__td_time"><%=scheduleTime%></td>
					<td class="table__td_schedule">

					<%for (Schedule schedule : scheduleList) {
							Integer scheduleId = schedule.getId();
							String scheduleStr = schedule.getSchedule();
							Date scheduleSqlDate = schedule.getScheduledate();
							Time startSqlTime = schedule.getStarttime();
							Time endSqlTime = schedule.getEndtime();
							LocalTime starttime = startSqlTime.toLocalTime();
							LocalTime endtime = endSqlTime.toLocalTime();
							LocalDate scheduledate = scheduleSqlDate.toLocalDate();

							int scheduleYear = scheduledate.getYear();
							int scheduleMonth = scheduledate.getMonthValue();
							int scheduleDay = scheduledate.getDayOfMonth();
							String scheduledateStr = scheduleYear + "-" + scheduleMonth + "-" + scheduleDay;

							int startHour = starttime.getHour();
							int startMinute = starttime.getMinute();
							int endHour = endtime.getHour();
							int endMinute = endtime.getMinute();
							int scheduleHour = scheduleTime.getHour();
							int scheduleMinute = scheduleTime.getMinute();

							if (scheduledateStr.equals(dateStr)) {
								if (startHour <= scheduleHour && scheduleHour <= endHour) {
									if (0 <= startMinute && startMinute < 30) {
										if (scheduleTime.isBefore(endtime)) {%>

						 <div class="table__td_schedule_link"><a href="scheduleedit?scheduleId=<%=scheduleId%>"><%=scheduleStr%></a></div>

									<%	}
									}
								}
							}
						}%>
					</td>
				</tr>
					<%
						scheduleTime = scheduleTime.plusMinutes(30);
					%>
				<tr class="table__tr after">
					<td class="table__td_time after"></td>
					<td class="table__td_schedule after">
					<%
						for (Schedule schedule : scheduleList) {
							Integer scheduleId = schedule.getId();
							String scheduleStr = schedule.getSchedule();
							Date scheduleSqlDate = schedule.getScheduledate();
							Time startSqlTime = schedule.getStarttime();
							Time endSqlTime = schedule.getEndtime();
							LocalTime starttime = startSqlTime.toLocalTime();
							LocalTime endtime = endSqlTime.toLocalTime();
							LocalTime endtimeMinus = endtime.minusMinutes(1);
							LocalDate scheduledate = scheduleSqlDate.toLocalDate();

							int scheduleYear = scheduledate.getYear();
							int scheduleMonth = scheduledate.getMonthValue();
							int scheduleDay = scheduledate.getDayOfMonth();
							String scheduledateStr = scheduleYear + "-" + scheduleMonth + "-" + scheduleDay;

							int startHour = starttime.getHour();
							int startMinute = starttime.getMinute();
							int endHour = endtime.getHour();
							int endMinute = endtime.getMinute();
							int scheduleHour = scheduleTime.getHour();
							int scheduleMinute = scheduleTime.getMinute();

							if (scheduledateStr.equals(dateStr)) {
								if (startHour <= scheduleHour && scheduleHour <= endHour) {
									if (0 <= startMinute && startMinute < 60) {
										if (scheduleTime.isBefore(endtime)) {
						%>
							<div class="table__td_schedule_link"><a href="scheduleedit?scheduleId=<%=scheduleId%>"><%=scheduleStr%></a></div>
						<%
										}
									}
								}
							}
						}
						%>
					</td>
				</tr>
						<%
						scheduleTime = scheduleTime.plusMinutes(30);
						%>
				<%
					}
				%>
			</table>
		</div>
		<div class="registration col-md-5 offset-1">
			<form class="form" action="" method="post">
				<div class="form__date row">
					<p class="col-2">日付:</p>
					<div class="col-6">
					<select name="registrationdateyear">
						<option value="<%=year%>"><%=year%></option>
					</select>年
					<select name="registrationdatemonth">
						<option value="<%=month%>"><%=month%></option>
					</select>月
					<select name="registrationdateday">
						<option value="<%=date%>"><%=date%></option>
					</select>日
					</div>
				</div>

				<c:if test="${not empty scheduleTimeError}">
					<span style="color:red;"><c:out value="${scheduleTimeError}" /></span>
				</c:if>
				<c:if test="${not empty scheduleTimeParseError}">
					<span style="color:red;"><c:out value="${scheduleTimeParseError}" /></span>
				</c:if>
				<div class="form__time row">
					<p class="col-2">時刻:</p>
					<div class="col-10">
					<select name="registrationtimestarthour">
						<option value="">--</option>
						<option value="00">00</option>
						<option value="01">01</option>
						<option value="02">02</option>
						<option value="03">03</option>
						<option value="04">04</option>
						<option value="05">05</option>
						<option value="06">06</option>
						<option value="07">07</option>
						<option value="08">08</option>
						<option value="09">09</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
						<option value="13">13</option>
						<option value="14">14</option>
						<option value="15">15</option>
						<option value="16">16</option>
						<option value="17">17</option>
						<option value="18">18</option>
						<option value="19">19</option>
						<option value="20">20</option>
						<option value="21">21</option>
						<option value="22">22</option>
						<option value="23">23</option>
					</select>時
					<select name="registrationtimestartminutes">
						<option value="">--</option>
						<option value="00">00</option>
						<option value="01">01</option>
						<option value="02">02</option>
						<option value="03">03</option>
						<option value="04">04</option>
						<option value="05">05</option>
						<option value="06">06</option>
						<option value="07">07</option>
						<option value="08">08</option>
						<option value="09">09</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
						<option value="13">13</option>
						<option value="14">14</option>
						<option value="15">15</option>
						<option value="16">16</option>
						<option value="17">17</option>
						<option value="18">18</option>
						<option value="19">19</option>
						<option value="20">20</option>
						<option value="21">21</option>
						<option value="22">22</option>
						<option value="23">23</option>
						<option value="24">24</option>
						<option value="25">25</option>
						<option value="26">26</option>
						<option value="27">27</option>
						<option value="28">28</option>
						<option value="29">29</option>
						<option value="30">30</option>
						<option value="31">31</option>
						<option value="32">32</option>
						<option value="33">33</option>
						<option value="34">34</option>
						<option value="35">35</option>
						<option value="36">36</option>
						<option value="37">37</option>
						<option value="38">38</option>
						<option value="39">39</option>
						<option value="40">40</option>
						<option value="41">41</option>
						<option value="42">42</option>
						<option value="43">43</option>
						<option value="44">44</option>
						<option value="45">45</option>
						<option value="46">46</option>
						<option value="47">47</option>
						<option value="48">48</option>
						<option value="49">49</option>
						<option value="50">50</option>
						<option value="51">51</option>
						<option value="52">52</option>
						<option value="53">53</option>
						<option value="54">54</option>
						<option value="55">55</option>
						<option value="56">56</option>
						<option value="57">57</option>
						<option value="58">58</option>
						<option value="59">59</option>
					</select>分
					<span>〜</span>
					<select name="registrationtimeendhour">
						<option value="">--</option>
						<option value="00">00</option>
						<option value="01">01</option>
						<option value="02">02</option>
						<option value="03">03</option>
						<option value="04">04</option>
						<option value="05">05</option>
						<option value="06">06</option>
						<option value="07">07</option>
						<option value="08">08</option>
						<option value="09">09</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
						<option value="13">13</option>
						<option value="14">14</option>
						<option value="15">15</option>
						<option value="16">16</option>
						<option value="17">17</option>
						<option value="18">18</option>
						<option value="19">19</option>
						<option value="20">20</option>
						<option value="21">21</option>
						<option value="22">22</option>
						<option value="23">23</option>
					</select>時
					<select name="registrationtimeendminutes">
						<option value="">--</option>
						<option value="00">00</option>
						<option value="01">01</option>
						<option value="02">02</option>
						<option value="03">03</option>
						<option value="04">04</option>
						<option value="05">05</option>
						<option value="06">06</option>
						<option value="07">07</option>
						<option value="08">08</option>
						<option value="09">09</option>
						<option value="10">10</option>
						<option value="11">11</option>
						<option value="12">12</option>
						<option value="13">13</option>
						<option value="14">14</option>
						<option value="15">15</option>
						<option value="16">16</option>
						<option value="17">17</option>
						<option value="18">18</option>
						<option value="19">19</option>
						<option value="20">20</option>
						<option value="21">21</option>
						<option value="22">22</option>
						<option value="23">23</option>
						<option value="24">24</option>
						<option value="25">25</option>
						<option value="26">26</option>
						<option value="27">27</option>
						<option value="28">28</option>
						<option value="29">29</option>
						<option value="30">30</option>
						<option value="31">31</option>
						<option value="32">32</option>
						<option value="33">33</option>
						<option value="34">34</option>
						<option value="35">35</option>
						<option value="36">36</option>
						<option value="37">37</option>
						<option value="38">38</option>
						<option value="39">39</option>
						<option value="40">40</option>
						<option value="41">41</option>
						<option value="42">42</option>
						<option value="43">43</option>
						<option value="44">44</option>
						<option value="45">45</option>
						<option value="46">46</option>
						<option value="47">47</option>
						<option value="48">48</option>
						<option value="49">49</option>
						<option value="50">50</option>
						<option value="51">51</option>
						<option value="52">52</option>
						<option value="53">53</option>
						<option value="54">54</option>
						<option value="55">55</option>
						<option value="56">56</option>
						<option value="57">57</option>
						<option value="58">58</option>
						<option value="59">59</option>
					</select>分
					</div>
				</div>
				<c:if test="${not empty scheduleError}">
					<span style="color:red;"><c:out value="${scheduleError}" /></span>
				</c:if>
				<div class="form__schedule row">
					<p class="col-2">予定:</p>
					<div class="col-8">
					<input class="form__schedule_text" type="text" name="schedule" value="<c:out value="${schedulestr}"/>">
					</div>
				</div>

				<div class="form__memo row">
					<p class="col-2">備考:</p>
					<div class="col-8">
					<textarea class="form__memo_textarea" name="memo" rows="6"><c:out value="${memo}"/></textarea>
					</div>
				</div>

				<div class="form__submit row">
					<div class="col-3 offset-2">
					<button type="submit" class="btn btn-primary form__submit_btn">登録</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>