<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>

</style>
<%@ include file="../include/header.jsp"%>
        <!-- Page content-->
       	<div class="container main-container">

		       	<div class="col-12 mb-3">
					<h2>예약확인</h2>
					<br>
					<c:choose>
						<c:when test="${empty list }">
							<h4 style="text-align:center; color : red;">예약된 기록이 없습니다.</h4>
						</c:when>
						<c:otherwise>
							<table class="table table-hover" style="text-align:center;">
									<tr>
										<th>날짜</th>
										<th>예약자</th>
										<th>연습실</th>
										<th>시간</th>
										<th>취소</th>
									</tr>
								<c:forEach items="${list }" var="list" varStatus="status">
									<tr>
										<td>${list.boDateStr }</td>
										<td>${list.meName }</td>
										<td>${list.roName }</td>
										<td>${list.boTime }</td>
										<td>
											<c:choose>
												<c:when test="${list.refused == '취소' }">
													<input type="button" class="btn btn-primary btn-md btn-block" style="border: none; border-radius: 50px; background-color: purple;" onclick="return cancel(event, ${status.count})" value="${list.refused }">
													<input type="hidden" id="roNo_${status.count}" value="${list.roNo }">
													<input type="hidden" id="meEmail_${status.count}" value="${list.meEmail}">
												</c:when>
												<c:otherwise>
													${list.refused }
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:forEach>
							</table>
						</c:otherwise>
					</c:choose>
				</div>
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
										href="/booking/bookingAdminList?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a></li>
								</c:if>
								<c:forEach begin="${paging.startPage }" end="${paging.endPage }"
									var="p">
									<c:choose>
										<c:when test="${p == paging.nowPage }">
											<li class="page-item"><a class="page-link" href="#">${p }</a></li>
										</c:when>
										<c:when test="${p != paging.nowPage }">
											<li class="page-item"><a class="page-link"
												href="/booking/bookingAdminList?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a></li>
										</c:when>
									</c:choose>
								</c:forEach>
								<c:if test="${paging.endPage != paging.lastPage }">
									<li class="page-item"><a class="page-link"
										href="/booking/bookingAdminList?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a></li>
								</c:if>
							</ul>
						</c:otherwise>
					</c:choose>
       	</div>
       	
       	<!-- modal -->
        <div class="modal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Result</h5>
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
function cancel(event, idx){
	event.preventDefault();
	console.log(idx);
	
	var roNo = $("#roNo_"+idx).val();
	var meEmail = $("#meEmail_"+idx).val();
	
	console.log(roNo +" "+ meEmail);
	if(confirm("삭제하시겠습니까?")){
		$.ajax({
			type : "post",
			url : "/booking/cancelBooking",
			data : {roNo : roNo,
					meEmail : meEmail},
			success : function(data){
				if(data == 'success'){
					alert("삭제되었습니다.");
				}
				location.reload();
			}
		});
	}
}

$(document).ready(function() {
	function messages(){
		var msg = '${msg}';
		console.log("msg>>", msg);
		if (!(msg === '' || history.state)) {
			var modal = $(".modal");
			console.log(modal);
			modal.modal();
		}
		
	}
});
</script>
	<%@ include file="../include/footer.jsp"%>

