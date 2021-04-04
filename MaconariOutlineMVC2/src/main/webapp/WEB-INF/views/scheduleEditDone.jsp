<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.example.maconarioutlinemvc.domain.Schedule"%>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Time" %>
<%
	Schedule schedule=(Schedule)request.getAttribute("schedule");
	String scheduleStr=schedule.getSchedule();
	String memo=schedule.getMemo();
	Date scheduleDate=schedule.getScheduledate();
	Time startTime=schedule.getStarttime();
	Time endTime=schedule.getEndtime();
	String scheduleDateStr=scheduleDate.toString();
	String startTimeStr=startTime.toString();
	String endTimeStr=endTime.toString();
	String[] scheduleDateStrHairetsu=scheduleDateStr.split("\\D");
	String[] startTimeStrHairetsu=startTimeStr.split("\\D");
	String[] endTimeStrHairetsu=endTimeStr.split("\\D");

	String year=scheduleDateStrHairetsu[0];
	String month=scheduleDateStrHairetsu[1];
	String date=scheduleDateStrHairetsu[2];

	String starttimeJi=startTimeStrHairetsu[0];
	String starttimeFun=startTimeStrHairetsu[1];

	String endtimeJi=endTimeStrHairetsu[0];
	String endtimeFun=endTimeStrHairetsu[1];
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link href="<c:url value="/resources/css/common.css" />" type="text/css" rel="stylesheet"/>
<title>スケジュール編集完了ページ</title>
</head>
<body>
<header class="container-fluid">
	<div class="header__inner row h-100 align-items-center">
		<h2 class="header__logo col-5 offset-1">スケジュールの編集が完了しました</h2>
		<p class="header__goback col-2 offset-3"><a href="schedule?year=<%=year%>&month=<%=month%>&date=<%=date%>">スケジュール登録画面へ戻る</a></p>
	</div>
</header>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>