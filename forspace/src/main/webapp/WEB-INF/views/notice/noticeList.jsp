<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>

</style>
<%@ include file="../include/header.jsp"%>
    <!-- Page content-->
	<div class="container">
		<div class="col-lg-12">
			<table class="table table-hover">
				<tr>
					<th>NO</th>
					<th>제목</th>
					<th>조회수</th>
				</tr>
				<c:forEach var="list" items="${list }">
					<tr>
						<td>${list.noNo }</td>
						<td><a href="/notice/noticeDetail?noNo=${list.noNo }">${list.noSubject }</a></td>
						<td>${list.noCnt }</td>
					</tr>
				</c:forEach>
			</table>
			
			<!-- paging -->
			
					<c:choose>
						<c:when test="${paging.total <6}">
							<ul></ul>
						</c:when>
						<c:otherwise>
							<ul class="pagination pagination-md"
								style="justify-content: center;">
								<c:if test="${paging.startPage != 1}">
									<li class="page-item"><a class="page-link"
										href="/notice/noticeList?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a></li>
								</c:if>
								<c:forEach begin="${paging.startPage }" end="${paging.endPage }"
									var="p">
									<c:choose>
										<c:when test="${p == paging.nowPage }">
											<li class="page-item"><a class="page-link" href="#">${p }</a></li>
										</c:when>
										<c:when test="${p != paging.nowPage }">
											<li class="page-item"><a class="page-link"
												href="/notice/noticeList?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a></li>
										</c:when>
									</c:choose>
								</c:forEach>
								<c:if test="${paging.endPage != paging.lastPage }">
									<li class="page-item"><a class="page-link"
										href="/notice/noticeList?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a></li>
								</c:if>
							</ul>
						</c:otherwise>
					</c:choose>
		</div>
	</div>
<script>

</script>
	<%@ include file="../include/footer.jsp"%>

