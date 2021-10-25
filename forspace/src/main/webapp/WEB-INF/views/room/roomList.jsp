<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="https://code.iconify.design/2/2.0.3/iconify.min.js"></script>
<style>
	.floorCnt{
		display:flex;
		justify-content: center;
  		align-items: center;
	}
	
</style>
<%@ include file="../include/header.jsp"%>

        <!-- Page content-->
        <div class="container mt-5 main-content">

        	<div class="row">

        		<div class="col-lg-12">
        		<!--층 수 시작-------------------------------------------------------------------------------------------------------------->
      				<div class="autoplay">
						<c:forEach var="roFloor" items="${floorList}">
							<div class="card" style="border-radius:80px;" onClick="location.href='/room/roomList?roFloor=${roFloor}'">
								<div class="card-body">
									<c:out value="${roFloor }"/>
								</div>
							</div>
						</c:forEach>
        			</div>
        		<!--층 수 끝--------------------------------------------------------------------------------------------------------------->
  	           
  	            <!-- 층별 연습실------------------------------------------------------------------------------------------------------------>
  	                <c:choose>
  	                	<c:when test="${empty list}">
  	                		<p class="text-center" style="color:red; font-size:20px;">등록된 연습실이 없습니다.</p>
  	                	</c:when>
  	                	<c:otherwise>
  	                	  	<div class="card-columns">
								<c:forEach var="list" items="${list }">
									<div class="card" style="border-radius:50px;">
										<div class="card-body text-center">
											<i onClick="location.href='/room/roomDetail?roNo=${list.roNo}'"><h5><c:out value="${list.roName }"/></h5></i>
											<i class="bi bi-suit-heart">
												<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart" viewBox="0 0 16 16" style="color:red;">
												<path d="m8 6.236-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z"/>
												</svg>
											</i>
											<span>${list.likeCnt }</span>
											<!-- 
											<i class="bi bi-suit-heart-fill">
												<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-suit-heart-fill" viewBox="0 0 16 16" style="color:red;">
  												<path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1z"/>
												</svg>
											</i>
											-->
										</div>
									</div>
								</c:forEach>
							</div>
  	                	</c:otherwise>
					</c:choose>
				<!-- 층별 연습실------------------------------------------------------------------------------------------------------------>
	             </div>
			</div>

        </div>

<script>
/* 	$(".bi-suit-heart").on("click",function(){
		alert("하뚜 클릭");
	}); */
	
	var meEmail = '<sec:authentication property="principal.memberDTO.meEmail"/>';
	$(document).ready(function(){
		//alert(meEmail);
	});
</script>
	<%@ include file="../include/footer.jsp"%>

