<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib  prefix="sec" uri="http://www.springframework.org/security/tags" %>


<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>FORSPACE</title>
		

  		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../resources/css/styles.css" rel="stylesheet" />

		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        
		<!-- Core theme JS-->
        <script src="../resources/js/scripts.js"></script>
        <style>
	        html,body{ 
	        	margin:0; 
	        	padding:0; 
	        	width:100%; 
	        	height:100%; 
	        	}
        	.wrapper{
        		display:flex;
        		min-height:100vh;
        		flex-direction:column;
        	}
        	.main-container{
        		flex:1;
        	}
			.navbar-custom{
				background-color:rgb(102, 58, 130);
			}
			.navbar-brand{
				color:white;
			}
			.nav-link{
				color:white;
			}
			
			footer{
				height:60px;
				background-color:rgb(102, 58, 130);
				width:100%;
				/*padding:30px 0;*/
			}
			.main-content{
				flex:1;
			}
		</style>
    </head>

<body>
<div class="wrapper">
       <!-- Responsive navbar-->
        <nav class="navbar navbar-expand-lg navbar-custom">
            <div class="container">
                <a class="navbar-brand" href="/">FORSPACE</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
						<sec:authorize access="isAnonymous()">
							<li class="nav-item dropdown no-arrow">
								<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
									data-toggle="dropdown" aria-haspopup="ture" aria-expanded="false" style="color:#d0342c;">
									<span class="mr-2 d-none d-lg-inline">게스트</span>
									<i class="fas fa-user-time fa-lg"></i>
								</a>
							<!-- Dropdown user information -->
								<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
									<a class="dropdown-item" href="/member/login">
										<i class="fas fa-user-check fa-sm fa-fw mr-2">로그인</i>
									</a>
									<a class="dropdown-item" href="/member/memberjoin">
										<i class="fas fa-user-plus fa-sm fa-fw mr-2">회원가입</i>
									</a>
								</div>
							</li>
						</sec:authorize>  
						<sec:authorize access="isAuthenticated()">
							<li class="nav-item"><a class="nav-link" href="../room/roomList">연습실</a></li>
	                        <li class="nav-item"><a class="nav-link" href="#!">공지사항</a></li>
	                        <li class="nav-item"><a class="nav-link" href="#!">문의사항</a></li>
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
									<a class="dropdown-item" href="/member/login">
										<i class="fas fa-user-check fa-sm fa-fw mr-2">정보수정</i>
									</a>
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