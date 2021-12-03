<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>

</style>
<%@ include file="../include/header.jsp"%>
        <!-- Page content-->
        <div class="container main-container">
        	<div class="row justify-content-center" style="display: flex; align-items: center; min-height: 500px;">
               <div class="col-xl-5 col-lg-5 col-md-5"> 
					<p style="font-size:25px;">로그인<p>
					<form class="user" action="../login" method="post">
						<div class="form-group">
							<input type="email" name="username" class="form-control form-control-user" placeholder="이메일 주소" />
						</div>
						<div class="form-group">
							<input type="password" name="password" class="form-control form-control-user" placeholder="비밀번호">
						</div>
						<button type="submit" class="btn btn-primary btn-lg btn-block btn-user">로그인</button>
					</form>
					<div class="form-group">
						<c:out value="${error }"></c:out>
						<c:out value="${logout }"></c:out>
					</div>
					<div class="text-center">
						<a class="small" href="../member/join">회원가입</a>
					</div>
                </div>
			</div>	
        </div>
<script>

</script>
	<%@ include file="../include/footer.jsp"%>

