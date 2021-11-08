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
	}
	</style>
  
  <body>
		
		<div class="wrapper d-flex align-items-stretch">
			<nav id="sidebar">
				<div class="p-4 pt-5">
		  		<a href="#" class="img logo rounded-circle">
		  			<img id="img" src="../resources/images/user.png" alt="profile">
		  		</a>
	        <ul class="list-unstyled components mb-5">
	          <li class="active">
	            <a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Home</a>
	            <ul class="collapse list-unstyled" id="homeSubmenu">
                <li>
                    <a href="#">Home 1</a>
                </li>
                <li>
                    <a href="#">Home 2</a>
                </li>
                <li>
                    <a href="#">Home 3</a>
                </li>
	            </ul>
	          </li>
	          <li>
	              <a href="#">About</a>
	          </li>
	          <li>
              <a href="#pageSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Pages</a>
              <ul class="collapse list-unstyled" id="pageSubmenu">
                <li>
                    <a href="#">Page 1</a>
                </li>
                <li>
                    <a href="#">Page 2</a>
                </li>
                <li>
                    <a href="#">Page 3</a>
                </li>
              </ul>
	          </li>
	          <li>
              <a href="#">Portfolio</a>
	          </li>
	          <li>
              <a href="#">Contact</a>
	          </li>
	        </ul>

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
	              	<li class="nav-item dropdown no-arrow">
						<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
										data-toggle="dropdown" aria-haspopup="ture" aria-expanded="false" style="color:#d0342c;">
							<span class="mr-2 d-none d-lg-inline">게스트</span>
							<i class="fas fa-user-time fa-lg"></i>
						</a>
					<!-- Dropdown user information -->
						<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
							<a class="dropdown-item" href="../member/login">
								<i class="fas fa-user-check fa-sm fa-fw mr-2">로그인</i>
							</a>
							<a class="dropdown-item" href="../member/memberjoin">
								<i class="fas fa-user-plus fa-sm fa-fw mr-2">회원가입</i>
							</a>
						</div>
					</li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
	                <li class="nav-item active">
	                    <a class="nav-link" href="/">Home</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="../room/roomList?roFloor=0">연습실</a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="../notice/noticeList">공지사항</a>
	                </li>
	                <li class="nav-item dropdown no-arrow">
	                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
										data-toggle="dropdown" aria-haspopup="ture" aria-expanded="false" style="color:#d0342c;">
							<span class="mr-2 d-none d-lg-inline">
								<sec:authentication property="principal.memberDTO.meName"/>
							</span>
							<i class="fas fa-user-time fa-lg"></i>
						</a>
						<!-- Dropdown user information -->
							<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
								<a class="dropdown-item" href="/member/checkPwd">
									<i class="fas fa-user-check fa-sm fa-fw mr-2">정보수정</i>
								</a>
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<a class="dropdown-item" href="/room/addroom">
									<i class="fas fa-user-plus fa-sm fa-fw mr-2">연습실 등록</i>
								</a>
							</sec:authorize>
								<a class="dropdown-item" href="/member/logout">
									<i class="fas fa-user-plus fa-sm fa-fw mr-2">로그아웃</i>
								</a>
							</div>
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
	}

});
</script>