<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
#noticeBtn{
	border: none;
	border-radius: 50px; 
	background-color: purple;
	text-align : center;
}
</style>
<%@ include file="../include/header.jsp"%>
    <!-- Page content-->
	<div class="container">
		<div class="col-lg-12">
		<p style="font-size:25px;">공지사항</p>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<div class="col-lg-3 mb-3" style="float : right;">
				<button type="button" class="btn btn-primary btn-md btn-block" id="noticeBtn" onclick="return noticeIns();">공지사항 등록</button>
			</div>
		</sec:authorize>
			<table class="table table-hover">
				<c:choose>
					<c:when test="${empty list }">
						<p class="text-center" style="color:red; font-size:20px;">등록된 내용이 없습니다.</p>
					</c:when>
					<c:otherwise>
						<tr>
							<th style="width:10%; text-align:center;">NO</th>
							<th style="width:70%; text-align:center;">제목</th>
							<th style="width:20%; text-align:center;">조회수</th>
						</tr>
						<c:forEach var="list" items="${list }">
							<tr>
								<td style="width:10%; text-align:center;">${list.noNo }</td>
								<td style="width:80%;"><a href="/notice/noticeDetail?noNo=${list.noNo }">${list.noSubject }</a></td>
								<td style="width:20%; text-align:center;">${list.noCnt }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
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
	
		<!-- modal -->
		<div class="modal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <p class="modal-title" style="font-size:25px;">Result</p>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>${msg }</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">Ok</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
<script>
$(document).ready(function(){
	var msg = '${msg}';
	if (!(msg===''||history.state)){
		var modal= $(".modal");
		modal.modal();
	}
});

function noticeIns(){
	location.href="../notice/noticeForm";
}
</script>
	<%@ include file="../include/footer.jsp"%>

