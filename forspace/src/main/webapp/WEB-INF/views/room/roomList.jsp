<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>

</style>
<%@ include file="../include/header.jsp"%>
        <!-- Page content-->
        <div class="container mt-5 main-content">
			<c:forEach var="floorList" items="${floorList }">
				<span>${floorList }</span>	
			</c:forEach>
        	<div class="row">
        		<div class="col-lg-8">
  	                <div class="card-columns">
		                <c:forEach var="dto" items="${list}">
							<div class="card" style="border-radius:50px;" onClick="location.href='#'">
								<div class="card-body text-center">
									<p class="card-text">${dto }</p>
								</div>
							</div>
						</c:forEach>
					</div>
	             </div>
				<%@ include file="../include/side.jsp"%>
			</div>

        </div>
<script>

</script>
	<%@ include file="../include/footer.jsp"%>

