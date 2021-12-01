<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib  prefix="sec" uri="http://www.springframework.org/security/tags" %>


<html>
  <head>
  	<title>Forspace</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">  
    
    	<link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet"> 

		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
		<link rel="stylesheet" href="../resources/css/style.css">
	
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/> <!-- 아이콘&ajax 사용 -->		
  		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
		
		<!-- slick -->		
		<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
		<script src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

		<!-- timepicker -->
		<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">        
		<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
		
  </head>
  
  	<style>
	.img{
		text-align : center;
		margin : 5px;
	}
	#img{
		border-radius: 50%;
		width : 100px;
		height : 100px;
	}
	</style>
  
  <body>
		
		<div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar">
				<div class="p-4 pt-5">
		  		<a href="#" class="img logo rounded-circle">
		  			<img id="img" src="../resources/images/user.png" alt="profile">
		  		</a>
		  	<sec:authorize access="isAnonymous()">
		  	<ul class="list-unstyled components mb-5">
	          <li>
	              <a href="../member/login">로그인</a>
	          </li>
	          <li>
	              <a href="../member/join">회원가입</a>
	          </li>
	          <li>
	        </ul>
		  	</sec:authorize>
		  	<sec:authorize access="isAuthenticated()">
	        <ul class="list-unstyled components mb-5">
	          <li class="active">
	            <a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">INFO</a>
	            <ul class="collapse list-unstyled" id="homeSubmenu">
                <li class="roNoLi">
                    
                </li>
	            </ul>
	          </li>
	          <sec:authorize access="hasRole('ROLE_ADMIN')">
	          <li>
	              <a href="../member/codeCheck">인증번호</a>
	          </li>
	          </sec:authorize>
	          
	          <li>
	              <a href="../member/checkPwd">내정보</a>
	          </li>
	          <li>
	              <a href="../member/logout">로그아웃</a>
	          </li>
	          <li>
	        </ul>
			</sec:authorize>
	        <div class="footer">
	        	<p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
						  Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="icon-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib.com</a>
						  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
	        </div>

	      </div>
    	</nav>

        <!-- Page Content  -->
      <div id="content" class="p-4 p-md-5">

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
          <div class="container-fluid">

            <button type="button" id="sidebarCollapse" class="btn btn-primary">
              <i class="fa fa-bars"></i>
              <span class="sr-only">Toggle Menu</span>
            </button>
            <button class="btn btn-dark d-inline-block d-lg-none ml-auto" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <i class="fa fa-bars"></i>
            </button>


            <div class="collapse navbar-collapse" id="navbarSupportedContent">
              <ul class="nav navbar-nav ml-auto">
              	<sec:authorize access="isAnonymous()">
              		<li class="nav-item">
	                    <a class="nav-link" href="../member/login">로그인</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="../member/join">회원가입</a>
	                </li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
	                <li class="nav-item">
	                    <a class="nav-link" href="../room/roomList?roFloor=0">연습실</a>
	                </li>
	               	<sec:authorize access="hasRole('ROLE_ADMIN')">
	               	<li class="nav-item">
	                    <a class="nav-link" href="../room/addroom">연습실등록</a>
	                </li>
	                </sec:authorize>
	                <sec:authorize access="hasRole('ROLE_USER')">
	               	<li class="nav-item">
	                    <a class="nav-link" href="../booking/bookingList">예약확인</a>
	                </li>
	                </sec:authorize>
	               	<sec:authorize access="hasRole('ROLE_ADMIN')">
	               	<li class="nav-item">
	                    <a class="nav-link" href="../booking/bookingAdminList">예약확인</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="../caution/cautionList">이용제한</a>
	                </li>
	                </sec:authorize>
	                <li class="nav-item">
	                    <a class="nav-link" href="../notice/noticeList">공지사항</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="#"><sec:authentication property="principal.memberDTO.meName"/></a>
	                </li>
	               </sec:authorize>
              </ul>
            </div>
          </div>
        </nav>


	<sec:authorize access="isAuthenticated()">
	    <sec:authentication property="principal.memberDTO.meRole" var="loginUserRole"/> 
	   	<sec:authentication property="principal.memberDTO.meEmail" var="loginUser"/> 
   	</sec:authorize>
   	
<script>
$(document).ready(function(){
	var user = "${loginUser}";
	var role = "${loginUserRole}";
	
	if(!(user == '') && !(user == null)){
		console.log("로그인 함");
		$.ajax({
			url : "/member/myProfileImg",
			type : "post",
			success : function(data){
				var img = data;
				console.log(img);
				var imgTag = $("#img");
				
				if(typeof img.imagePath == "undefined" || img.imagePath == null || img.imagePath == ""){
					imgTag.attr("src", "../resources/images/user.png");
				}else{
					imgTag.attr("src", "/image/show?imagePath="+img.imagePath);
				}
			}
		});
		
		var str = "";
		if(role == 'ADMIN'){
			
			$.ajax({
				url : "/complaint/todayComplaint",
				type : "post",
				data : {meEmail : user},
				success : function(data){
					console.info(data);
					if(data.length > 0){
						$.each(data, function(index, dto){
							str += "<a href='../room/roomDetail?roNo="+dto.roNo+"'>"+dto.roName+" "+dto.coContent+"</a>"
						});
						$(".roNoLi").append(str);
					}else{
						str += "<a href='#'>불편사항이 없습니다.</a>"
						$(".roNoLi").append(str);
					}
				},
				error : function(){
					
				}
			});
		}else if(role == 'USER'){
			$.ajax({
				url : "/booking/todayBooking",
				type : "post",
				data : {meEmail : user},
				success : function(data){
					console.info(data);
					if(data.length > 0){
						$.each(data, function(index, dto){
							str += "<a href='../room/roomDetail?roNo="+dto.roNo+"'>"+dto.roName+"호 "+dto.boTime+"</a>"
						});
						$(".roNoLi").append(str);
					}else{
						str += "<a href='#'>금일 예약이 없습니다.</a>"
						$(".roNoLi").append(str);
					}
				}
			});
		}
	}

});

</script>