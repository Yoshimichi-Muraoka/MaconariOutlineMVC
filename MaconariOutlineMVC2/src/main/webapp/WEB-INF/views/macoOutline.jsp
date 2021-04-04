<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<style>
	.header__nav{
		text-align:right;
	}

	.header__nav-item{
		display:inline;
		margin-left:20px;
	}

	.header__nav-item_link{
		color:black;
	}

	.header__nav-item_link:hover{
		color:silver;
	}

	.table{
		text-align: justify;
	}

	th{
		text-align:center;
		border-bottom-style:solid;
		vertical-align:bottom;
	}

	.table__td_button{
		text-align:center;
	}
</style>
<title>アウトライン一覧表示ページ</title>
</head>
<body>
<header class="container-fluid">
	<div class="header__inner row h-100 align-items-center">
		<h2 class="header__logo col-md-4 offset-1">アウトライン一覧</h2>
				<ul class="header__nav col-md-4 offset-2">
					<li class="header__nav-item"><a class="header__nav-item_link" href="<spring:url value= "/outlineadd" />" >新規アウトライン登録</a></li>
					<li class="header__nav-item"><a class="header__nav-item_link" href="logout">ログアウト</a></li>
				</ul>
	</div>
</header>
<div class="container mt-4">
	<table class="table table-striped">
		<tr class="table__row">
			<th class="table__th" style="vertical-align:middle;">アウトライン</th>
			<th class="table__th" style="vertical-align:middle; width:10%;">達成計画</th>
			<th class="table__th" style="vertical-align:middle; width:10%;">削除</th>
		</tr>
  		<c:forEach items="${outlineList}" var="outline">
  		<tr class="table__row">
		    <td class="table__td" style="vertical-align:middle;"><a href="outlineedit/<c:out value="${outline.id}" />"><c:out value="${outline.goal}"/></a></td>
		    <td class="table__td_button" style="vertical-align:middle;"><a href="calendar/<c:out value="${outline.id}" />"><button type="button" class="btn btn-primary btn-sm">カレンダー</button></a></td>
		    <td class="table__td_button" style="vertical-align:middle;"><a href="outlinedelete/<c:out value="${outline.id}" />"><button type="button" class="btn btn-danger btn-sm">削除</button></a></td>
  		</tr>
  		</c:forEach>
	</table>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>