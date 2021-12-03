<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
#joinImg{
	margin-top : 50px;
	width : 50%;
}
#madeIcon{
	font-size : 13px;
	float : right;
	position : fixed;
	bottom : 15px;
}
</style>
<%@ include file="../include/header.jsp"%>
        <!-- Page content-->
        <div class="container">
        	<div class="row">
        		<div class="col-lg-6 joinDIV">	
        			<p style="font-size:25px; text-align:center;">이용자<p>
        			<a class="btn" id="joinBtn" onclick="location.href='../member/memberjoin'">
        				<img src="../resources/images/premium-icon-guitar-193130.png" alt="member" id="joinImg">
        			</a>
        		</div>
        		<div class="col-lg-6 joinDIV">
        			<p style="font-size:25px; text-align:center;">관리자<p>
        			<a class="btn" id="joinBtn" onclick="location.href='../member/adminjoin'">
        				<img src="../resources/images/premium-icon-keyboard-193137.png" alt="admin" id="joinImg">
        			</a>
        		</div>
        	</div>
        </div>
        <div class="mb-0" id="madeIcon">아이콘 제작자 <a href="https://www.flaticon.com/kr/authors/webalys" title="Webalys">Webalys</a> from <a href="https://www.flaticon.com/kr/" title="Flaticon">www.flaticon.com</a></div>
<script>
</script>
	<%@ include file="../include/footer.jsp"%>

