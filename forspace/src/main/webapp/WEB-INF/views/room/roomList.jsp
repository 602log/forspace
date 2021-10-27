<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="https://code.iconify.design/2/2.0.3/iconify.min.js"></script>
<style>
	.floorCnt{
		display:flex;
		justify-content: center;
  		align-items: center;
	}

	.likeBtn .heart-shape{
		display : inline;
		color : red;
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
											<c:choose>
												<c:when test="${list.myLike == 0}">
													<a class="btn likeBtn" data-rono="${list.roNo }">
														<span class="heart-shape">♡</span>
													</a>
												</c:when>
												<c:otherwise>
													<a class="btn likeBtn" data-rono="${list.roNo }">
														<span class="heart-shape">♥</span>
													</a>
												</c:otherwise>
											</c:choose>
											<span class="like-count">${list.roLikecnt }</span>
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

$(document).on("click", ".likeBtn", function(e){
	var roNo = $(this).data("rono");
	var meEmail = '${loginUser}';
	
	//alert(roNo + meEmail);

	$.ajax({
		type : "POST",
		url : "/room/insertLike",
		data : {roNo : roNo,
				meEmail : meEmail},
		dataType : "text",
		success : function(data){
			if(data == "like"){
				$(".heart-shape").text("♥");
				
			}else{
				$(".heart-shape").text("♡");
				
			}
			location.reload();
		}
	});

});

</script>
	<%@ include file="../include/footer.jsp"%>

