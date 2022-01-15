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
  	//수정기능
  	function upClick(idx){ //idx에 맞는 content가져오기
  		var contents=$("#c"+idx).val();
  		$.ajax({
  			url : "${cpath}/boardContentUpdateAjax.do",
  			type:"post",
  			data:{"idx":idx, "contents":contents},
  			success: loadList,
  			error: function(){
  				alert("error");
  			}
  		});
  	}
  	function loadList(){
  		$.ajax({
  			url:"${cpath}/boardListAjax.do",
  			type:"get",
  			dataType:"json", //데이터 받는 타입
  			success: listView, //콜백 함수
  			error:function(){alert("error");}
  		});
  	}//							  0		1		2
  	function listView(data){ //{board},{board},{   }
  		//동적으로 게시판 만들기
  		var blist="<table class = 'table table-hover'>";
  		blist+="<tr>";
  		blist+="<td>번호</td>";
  		blist+="<td>제목</td>";
  		blist+="<td>작성자</td>";
  		blist+="<td>작성일</td>";
  		blist+="<td>조회수</td>";
  		blist+="<td>수정</td>";
  		blist+="<td>삭제</td>";
  		blist+="</tr>";
  		$.each(data,function(index,obj){
  			blist+="<tr>";
  	  		blist+="<td>"+obj.idx+"</td>";
  	  		blist+="<td id='t"+obj.idx+"'><a href='javascript:goContent("+obj.idx+")'>"+obj.title+"</a></td>";
  	  		blist+="<td id = 'w"+obj.idx+"'>"+obj.writer+"</td>";
  	  		blist+="<td>"+obj.indate+"</td>";
  	  		blist+="<td>"+obj.count+"</td>";
  	  		blist+="<td id = 'u"+obj.idx+"'><button class='btn btn-info btn-sm' onclick='goUpdate("+obj.idx+")'>수정</button></td>"; //upclick은 제목만 수정
  	  		blist+="<td><button class='btn btn-warning btn-sm' onclick='goDelete("+obj.idx+")'>삭제</button></td>";
  	  		blist+="</tr>";
  	  		
  		//제목 눌렀을 때 나오는 화면 
            blist+="<tr id='cv"+obj.idx+"' style='display:none'>";
            blist+="<td>내용</td>";
            blist+="<td colspan='6'><textarea rows='7' id='c"+obj.idx+"' class='form-control'>"+obj.contents+"</textarea>";
            blist+="<br/>";
           blist+="<button class='btn btn-info btn-sm' onclick='upClick("+obj.idx+")'>수정</button>";
           blist+="&nbsp;<button class='btn btn-warning btn-sm'>취소</button>";
           blist+="&nbsp;<button class='btn btn-danger btn-sm' onclick='goClose("+obj.idx+")'>닫기</button>";
           blist+="</td>";
            blist+="</tr>";
  		});
	      
  		
  		blist+="<tr>";
  		blist+="<td colspan='7'>";
  		blist+="<button class = 'btn btn-primary btn-sm' onclick='goForm()'>글쓰기</button>";
  		blist+="</td>";
  		blist+="</tr>";
  		
  		
  		
  		blist+="</table>";
  		$(".blist").html(blist);
  	}
  	function goUpdate(idx){ //클릭시 제목,작성자,수정 업데이트 필요
  		var title=$("#t"+idx).text(); //기존 값 가져오기
  		var newTitle="<input type='text' id = 'nt"+idx+"' class='form-control' value='"+title+"'>";
  		$("#t"+idx).html(newTitle);
  		
  		var writer=$("#w"+idx).text();
  		var newWriter="<input type='text' id = 'nw"+idx+"' class='form-control' value = '"+writer+"'>";
  		$("#w"+idx).html(newWriter);
  	
  		var newUpdate="<button class='btn btn-success btn-sm' onclick='update("+idx+")'>수정하기</button>"
  		$("#u"+idx).html(newUpdate);
  	}
  	function update(idx){ //idx 가져와서 title,writer 수정 내용 저장하기
  		var title=$("#nt"+idx).val();
  		var writer=$("#nw"+idx).val();
  		
  		$.ajax({
  			url: "${cpath}/boardTWUpdateAjax.do",
  			type:"post",
  			data:{"idx":idx, "title":title, "writer":writer},
  			success: loadList,
  			error:function(){alert("error");}
  		});
  	}
  	
  	function goDelete(idx){
  		$.ajax({
  			url:"${cpath}/boardDeleteAjax.do",
  			type : "get",
  			data : {"idx":idx},
  			success: loadList,
  			error:function(){alert("error");}
  		});
  	} 
  	
  	function goClose(idx){
        $("#cv"+idx).css("display","none");
     }
     
     function goContent(idx){
        if($("#cv"+idx).css("display")=="none"){
          $("#cv"+idx).css("display","table-row");
        }else{
           $("#cv"+idx).css("display","none");
        }
     }
  	
  	function goForm(){
  		if($(".rform").css("display")=="block"){
  			//$(".rform").css("display","none");
  			$(".rform").slideUp();
  		}else{
  		//$(".rform").css("display","block");
  		$(".rform").slideDown();
  		}
  	}
  	function goInsert(){ //title,contents,writer정보 가져오기
  		//var title = $("#title").val();
  		//var contents = $("#contents").val();
  		//var writer = $("#writer").val();
  		var fData=$("#frm").serialize(); //직렬화 , 폼 안에 있는 파라미터 한번에 가져오기
  		//데이터 보내기(비동기식)
  		$.ajax({
  			url:"${cpath}/boardInsertAjax.do",
  			type : "post",
  			data : fData,
  			success: loadList,
  			error:function(){alert("error");}
  		});
  		
  		//취소버튼을 강제로 클릭하기
  		$(".cancel").trigger("click");
  		
  		$(".rform").css("display","none"); //글 쓴 다음에 안보이게 됨 
  	}
  	
  	
  </script>
</head>
<body>

<div class = "container">
	<h2>Spring WEB MVC02(jQuery+Ajax+JSON)</h2>
	<div class = "panel panel-default">
	<div class = "panel-heading">SPRING BOARD</div>
	<div class = "panel-body blist">Panel Content</div>
	<div class="panel-body rform" style="display:none">
	<!-- 글쓰기 UI -->
	<form id = "frm" class="form-horizontal" method = "post"> 
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="title">제목:</label>
		    <div class="col-sm-10">								<!-- 서버로 전송하기 위해 Parameter이름, board 이름, 데이터베이스 이름과 동일하게 설정 -->
		      <input type="text" class="form-control" id="title" name = "title" placeholder="Enter title">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="contents">내용:</label>
		    <div class="col-sm-10"> <!-- 10:2의 비율 -->
		      <textarea rows = "10" class = "form-control" id="contents" name = "contents"></textarea>
		  </div>
		  </div>
		  
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="writer">작성자:</label>
		    <div class="col-sm-10"> 
		      <input type="text" class="form-control" id="writer" name = "writer" placeholder="Enter writer">
		    </div>
		  </div>

		  <div class="form-group"> 
		    <div class="col-sm-offset-2 col-sm-10">
		      <button type="button" class="btn btn-success btn-sm" onclick="goInsert()">글쓰기</button>
		      <button type="reset" class="btn btn-warning btn-sm cancel">취소</button>
		      
		    </div>
		  </div>
		</form>
	
	</div>
	
	<div class = "panel-footer">빅데이터 분석서비스 개발자과정 김정미</div>
	</div>
</div>

</body>
</html>