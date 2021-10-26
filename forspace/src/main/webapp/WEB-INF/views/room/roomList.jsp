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

</script>
	<%@ include file="../include/footer.jsp"%>

