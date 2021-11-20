<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
h4{
	text-align:center;
}

img{
	margin-top : 30px;
	width : 50%;
	opacity: 0.5;
}
</style>
<%@ include file="../include/header.jsp"%>
        <!-- Page content-->
        <div class="container">
        	<div class="row">
        		<div class="col-lg-6 joinDIV">	
        			<h4>이용자</h4>
        			<a class="btn" id="joinBtn" onclick="location.href='../member/memberjoin'">
        				<img src="../resources/images/guitar-pick.png" alt="member">
        			</a>
        		</div>
        		<div class="col-lg-6 joinDIV">
        			<h4>관리자</h4>
        			<a class="btn" id="joinBtn" onclick="location.href='../member/adminjoin'">
        				<img src="../resources/images/plectrum.png" alt="admin">
        			</a>
        		</div>
        	</div>
        </div>
<script>
</script>
	<%@ include file="../include/footer.jsp"%>

