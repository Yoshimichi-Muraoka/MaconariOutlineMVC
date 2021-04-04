<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link href="<c:url value="/resources/css/common.css" />" type="text/css" rel="stylesheet"/>
<style>
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
<title>会員登録ページ</title>
</head>
<body>
<header class="container-fluid">
	<div class="header__inner row h-100 align-items-center">
		<h2 class="header__logo col-4 text-center">新規会員登録</h2>
		<p class="header__goback col-3 offset-5"><a href="login">ログインページへ戻る</a></p>
	</div>
</header>
<div class="container">
	<div class="container__inner w-25">
		<p class="form-message">作成するアカウントのログインIDとパスワードを半角英数字4文字で設定してください</p>
		<form:form class="form" modelAttribute ="admin" action="" method="post">
			<p style="color:red;"><c:out value="${loginIdError}" /></p>
			<p style="color:red;"><c:out value="${loginIdDuplicateError}" /></p>
 			<div class="form__item form__id">
				<label for="exampleInputLoginId" class="form-label">ログインID</label>
		    	<form:input class="form-control" id="exampleInputLoginId" path="loginId" />
			</div>
  			<p style="color:red;"><c:out value="${loginPassError}" /></p>
  			<div class="form__item form__pass">
				<label for="exampleInputPassword1" class="form-label">パスワード</label>
				<form:password class="form-control" id="exampleInputPassword1" path="loginPass" />
			</div>
  			<div class="form__item form__submit">
				<button type="submit" class="btn btn-primary">会員登録</button>
			</div>
		</form:form>
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>