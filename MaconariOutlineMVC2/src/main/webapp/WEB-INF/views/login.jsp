<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link href="<c:url value="/resources/css/common.css" />" type="text/css" rel="stylesheet"/>
<style>
	.header__nav{
		text-align:right;
	}

	.header__nav-item{
		display:inline;
		margin-left:20px;
	}

	.container{
		height:800px;
		position:relative;
	}

	.container__inner{
		background-color:#EEEEEE;
		position:absolute;
		top:150px;
		right:38%;
		padding-top:30px;
		padding-left:15px;
		padding-right:15px;
		padding-bottom:60px;
		border-radius:20px 20px 20px 20px;
	}

	.form-message{
		background-color:#EEEEEE;
		text-align:center;
		font-size:270%;
		font-family:"ヒラギノ角ゴ StdN";
	}

	.form{
		background-color:#EEEEEE;
	}

	.form__item{
		background-color:#EEEEEE;
		margin-top:25px;
	}

	.btn{
		width:100%;
	}
</style>
<title>ログインフォーム</title>
</head>
<body>
<header class="container-fluid">
	<div class="header__inner row h-100 align-items-center">
		<h2 class="header__logo col-7 text-center">マコなり社長アウトライン作成システム</h2>
				<ul class="header__nav col-5 text-center">
					<li class="header__nav-item"><a href="addadmin">新規会員登録</a></li>
					<li class="header__nav-item"><a href="deleteadmin">退会</a></li>
				</ul>
	</div>
</header>

<div class="container">
	<div class="container__inner w-25">
		<p class="form-message">Sign in</p>
			<form:form class="form" modelAttribute ="admin" action="" method="post">
				<p style="color:red;"><c:out value ="${loginError}" /></p>
				<div class="form__item form__id">
					<label for="exampleInputLoginId" class="form-label">ログインID</label>
		    		<form:input class="form-control" id="exampleInputLoginId" path="loginId" />
				</div>

				<div class="form__item form__pass">
					<label for="exampleInputPassword1" class="form-label">パスワード</label>
					<form:password class="form-control" id="exampleInputPassword1" path="loginPass" />
				</div>
				<div class="form__item form__submit">
					<button type="submit" class="btn btn-primary">ログイン</button>
				</div>
			</form:form>
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>
