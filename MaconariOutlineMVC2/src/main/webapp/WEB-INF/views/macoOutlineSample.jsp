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
<link href="<c:url value="/resources/css/common.css" />" type="text/css" rel="stylesheet"/>
<style>
	p{
		font-weight:bold;
	}

	.continer__message{
		text-align:center;
		margin-bottom:30px;
	}

	.table__th{
		width:20%;
		text-align:center;
	}

	.table__td{
		width:80%;
		text-align:justify;
	}
	.table__td_message{
		font-family:"ヒラギノ角ゴ";
		color:red;
		margin-top:18px;
		margin-bottom:18px;
	}
</style>
<title>記入例表示ページ</title>
</head>
<body>
<header class="container-fluid">
	<div class="header__inner row h-100 align-items-center">
		<h2 class="header__logo col-5 offset-2">記入例</h2>
		<p class="header__goback col-3 offset-1"><a href="<spring:url value= "/outlineadd" />" >新規アウトライン登録ページへ戻る</a></p>
	</div>
</header>
<div class="container mt-5 mb-5">
	<div class="container__inner">
		<p class="continer__message">古い営業資料を新しくする場合のアウトライン</p>
			<table class="table table-striped" border="1">
				<tr>
					<th class="table__th" style="vertical-align:middle;">ゴール</th>
					<td class="table__td" style="vertical-align:middle;">
						よりお客様から信頼される資料にすることで成約率を上げる
						<p class="table__td_message">
							ゴールは本当に得たい成果について考える。<br>
							営業資料を新しくするのなら『古い営業資料を新しくすること』がゴールではなく,
							『よりお客様から信頼される資料にすることで成約率を上げること』がゴールとなる。
							つまり何のためにその作業をする必要があるのかを考え、それをふまえた上でゴールを決める。
						</p>
					</td>
				</tr>
				<tr>
					<th class="table__th" style="vertical-align:middle;">ゴール(具体的化)</th>
					<td class="table__td" style="vertical-align:middle;">
						お客様から信頼される資料とは＝<br>
						情報が正しく最新である、高品質に感じる見た目、サービスの価値がわかりやすい
						<p class="table__td_message">
							このパートでは定めたゴールを誰が見ても解釈のずれがないよう具体的にする。
							上記のゴールは『よりお客様から信頼される資料』の部分が曖昧なので、この部分を具体的にする。
						</p>
					</td>
				</tr>
				<tr>
					<th class="table__th" style="vertical-align:middle;">課題</th>
					<td class="table__td" style="vertical-align:middle;">
						資料の引用に古いデータがある、スライドのデザインが良くない、サービスの売りが一目でわかりにくい
						<p class="table__td_message">
							次にゴールを達成するための現状の課題を洗い出していく。上記の例だと、
							資料の引用に古いデータがある、スライドのデザインが良くない、サービスの売りが一目でわかりにくいというのが現状の課題ということになる。
							それぞれの課題が、具体的にしたゴールの項目に対応しているのが分かる。
							ゴールを具体的にすればするほど、課題は自然と浮かび上がってくる。
						</p>
					</td>
				</tr>
				<tr>
					<th class="table__th" style="vertical-align:middle;">解決策</th>
					<td class="table__td" style="vertical-align:middle;">
						資料の引用に古いデータがある＝引用データを最新にする、スライドのデザインが良くない＝新しいデザインを社内のデザイナーさんに考えてもらう、
						サービスの売りが一目でわかりにくい＝一番最初のスライドに売りが一目でわかるものを書く
						<p class="table__td_message">
						最後にそれぞれの課題を解決するための具体的な行動を考えていく。
						ここまで具体的に文章化できたら、上司や同僚にフィードバックをもらう。
						上司から、これで進めて良いと許可が出たら作ったアウトラインを基に達成計画を作成し実行する。
						達成計画は必ず一つ一つの項目に期日を設定する。
						</p>
					</td>
				</tr>
			</table>
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
</body>
</html>