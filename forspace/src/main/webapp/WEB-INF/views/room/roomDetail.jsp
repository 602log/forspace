<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
</style>
<%@ include file="../include/header.jsp"%>
<!-- Page content-->
<div class="container mt-5 main-content">
	<div class="row">
		<div class="col-lg-8">
			<div class="row">
				<div class="col-lg-6">
					<h4 style="text-align: center;">연습실 상세정보</h4>
					<div class="card shadow h-20 py-2 mb-4">
						<div class="card-body py-2">
							<div class="row no-gutters align-items-center">
								<div class="col">
									<div class="text-sm font-weight-bold text-primary text-uppercase mb-1">건물층</div>
									<div class="h5 mb-0">${dto.roFloor }</div>
								</div>
							</div>
						</div>
					</div>



					<div class="card shadow h-20 py-2 mb-4">
						<div class="card-body py-2">
							<div class="row no-gutters align-items-center">
								<div class="col">
									<div class="text-sm font-weight-bold text-primary text-uppercase mb-1">최대수용인원</div>
									<div class="h5 mb-0">${dto.roMax }명까지</div>
								</div>
							</div>
						</div>
					</div>



					<div class="card shadow h-20 py-2 mb-4">
						<div class="card-body py-2">
							<div class="row no-gutters align-items-center">
								<div class="col">
									<div class="text-sm font-weight-bold text-primary text-uppercase mb-1">이용가능시간</div>
									<div class="h5 mb-0">${dto.roStart }~${dto.roClose }</div>
								</div>
							</div>
						</div>
					</div>

					<div class="card shadow h-20 py-2 mb-4">
						<div class="card-body py-2">
							<div class="row no-gutters align-items-center">
								<div class="col">
									<div class="text-sm font-weight-bold text-primary text-uppercase mb-1">기본예약시간</div>
									<div class="h5 mb-0">예약 1회당 ${dto.roLimit } 시간 이용가능</div>
								</div>
							</div>
						</div>
					</div>
				</div>


				<div class="col-lg-6">
					<h4 style="text-align: center;">연습실 옵션</h4>
					<c:choose>
						<c:when test="${empty items }">
							<p class="text-center" style="font-size: 20px;">옵션이 없습니다.</p>
						</c:when>
						<c:otherwise>
							<c:forEach items="${items }" var="items">
								<div class="card shadow h-20 py-2 mb-4">
									<div class="card-body py-2">
										<div class="row no-gutters align-items-center">
											<div class="col">
												<div class="h5 mb-0">${items.itemDTO.itName } ${items.riCnt}개</div>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>

				<div class="col-lg-12" style="background-color: red;">
				<table>
					<tr>
						<th>내용</th>
						<th>처리완료일</th>
					</tr>
					<c:forEach var="com" items="${com }">
						<tr>
							<td>${com.coContent }</td>
							<c:choose>
								<c:when test="${com.coFinish == '' || com.coFinish == null }">
									<td>미처리</td>
								</c:when>
								<c:otherwise>
									<td>${com.coFinish }</td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</table>
				<c:choose>
					<c:when test="${paging.total <6}">
						<ul></ul>
					</c:when>
					<c:otherwise>
						<ul class="pagination pagination-sm">
							<c:if test="${paging.startPage != 1}">
								<li class="page-item"><a class="page-link" href="/room/roomDetail?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}&roNo=${roNo}">&lt;</a></li>
							</c:if>
						    <c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
						    	<c:choose>
						    		<c:when test="${p == paging.nowPage }">
						    			<li class="page-item"><a class="page-link" href="#">${p }</a></li>
						    		</c:when>
						    		<c:when test="${p != paging.nowPage }">
						    			<li class="page-item"><a class="page-link" href="/room/roomDetail?nowPage=${p }&cntPerPage=${paging.cntPerPage}&roNo=${roNo}">${p }</a></li>
						    		</c:when>
						    	</c:choose>
						    </c:forEach>
						    <c:if test="${paging.endPage != paging.lastPage }">
						    	<li class="page-item"><a class="page-link" href="/room/roomDetail?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}&roNo=${roNo}">&gt;</a></li>
						    </c:if>
						 </ul>
					 </c:otherwise>
				 </c:choose>
				</div>
			</div>
		</div>

		<div class="col-lg-4" style="background-color: yellow;">
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<button type="button" class="btn btn-secondary btn-lg btn-block"
					style="border: none; border-radius: 50px; background-color: purple;">수정하기</button>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_USER')">
				<button type="button" class="btn btn-primary btn-lg btn-block"
					style="border: none; border-radius: 50px; background-color: purple;">예약하기</button>
			</sec:authorize>

		</div>
	</div>

</div>
<script>

</script>
<%@ include file="../include/footer.jsp"%>

