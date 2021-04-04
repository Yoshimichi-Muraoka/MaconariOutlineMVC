<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link href="<c:url value="/resources/css/common.css" />" type="text/css" rel="stylesheet"/>
<style>
	.table{
		text-align:center;
	}

	.table__th{
		width:20%;
	}

	.table__td{
		width:80%;
	}

	.textarea{
		width:100%;
	}
</style>
<title>アウトラインの編集</title>
</head>
<body>
<header class="container-fluid">
	<div class="header__inner row h-100 align-items-center">
		<h2 class="header__logo col-5 offset-1">アウトラインの編集</h2>
		<p class="header__goback col-2 offset-3"><a href="<spring:url value= "/outline" />" >アウトライン一覧へ戻る</a></p>
	</div>
</header>
<div class="container mt-4 mb-1">
	<div class="container__inner">
		<form:form modelAttribute="outline" action="" method="post">
		<table class="table table-striped" border="1">
			<tr>
				<th class="table__th" style="vertical-align:middle;">ゴール</th>
				<td class="table__td" style="vertical-align:middle;">
					<p style="color:red;"><c:out value="${goalEmptyError}" /></p>
					<p style="color:red;"><c:out value="${goalLengthError}" /></p>
					<form:textarea class="textarea" path="goal" rows="10"/>
				</td>
			</tr>
			<tr>
				<th class="table__th" style="vertical-align:middle;">ゴール(具体的化)</th>
				<td class="table__td" style="vertical-align:middle;">
					<p style="color:red;"><c:out value="${gutaitekiGoalLengthError}" /></p>
					<form:textarea class="textarea" path="gutaitekigoal" rows="10"/>
				</td>
			</tr>
			<tr>
				<th class="table__th" style="vertical-align:middle;">課題</th>
				<td class="table__td" style="vertical-align:middle;">
					<p style="color:red;"><c:out value="${kadaiLengthError}" /></p>
					<form:textarea class="textarea" path="kadai" rows="10"/>
				</td>
			</tr>
			<tr>
				<th class="table__th" style="vertical-align:middle;">解決策</th>
				<td class="table__td" style="vertical-align:middle;">
					<p style="color:red;"><c:out value="${kaiketsusakuLengthError}" /></p>
					<form:textarea class="textarea" path="kaiketsusaku" rows="10"/>
				</td>
			</tr>
		</table>
		<button type="submit" class="btn btn-primary btn-lg">更新</button>
		</form:form>
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>