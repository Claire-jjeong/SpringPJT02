<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<c:set var="cpath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang ="en" >
<head>
<meta charset="UTF-8">
<title>Bootstrap Example</title>
	<meta name ="viewport" content = "width=device-width, initial-scale = 1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <!-- jQuery 시작 : 자바스크립트 라이브러리  -->
  <script type="text/javascript">
  	$(document).ready(function(){
  		//서버와 통신 ($.ajax())
  		loadList();
  	});
  	function loadList(){
  		$.ajax({
  			url:"${cpath}/boardListAjax.do",
  			type:"get",
  			dataType:"json", //데이터 받는 타입
  			success: listView, //콜백 함수
  			error:function(){alert ("error");}
  		});
  	}
  	function listView(data){
  		
  	}
  </script>
</head>
<body>

<div class = "container">
	<h2>Spring WEB MVC02(jQuery+Ajax+JSON)</h2>
	<div class = "panel panel-default">
	<div class = "panel-heading">SPRING BOARD</div>
	<div class = "panel-body">Panel Content</div>
	<div class = "panel-footer">빅데이터 분석서비스 개발자과정 김정미</div>
	</div>
</div>

</body>
</html>