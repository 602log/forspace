<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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

        		<div class="col-lg-8">
	        			<c:forEach var="floorList" items="${floorList }">
							<button class="btn col-lg-3 ms-3" type="button" onClick="location.href='room/roomFloor?roFloor=${floorList}'"><H1>${floorList }</H1></button>	
						</c:forEach>
  	                <div class="card-columns">
		                <c:forEach var="dto" items="${list}">
							<div class="card" style="border-radius:50px;" onClick="location.href='/room/roomDetail?roName=${dto}'">
								<div class="card-body text-center">
									<p class="card-text">${dto }</p>
								</div>
							</div>
						</c:forEach>
					</div>
	             </div>
			</div>

        </div>
<script>

/* 	$("button[id^='floorBtn']").on("click", function(){

	}); */

</script>
	<%@ include file="../include/footer.jsp"%>

