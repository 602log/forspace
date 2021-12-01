<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>

</style>
<%@ include file="../include/header.jsp"%>
        <!-- Page content-->
       	<div class="container main-container">

		       	<div class="col-12 mb-3">
					<p style="font-size:25px;">이용제한</p>
					<br>
					<c:choose>
						<c:when test="${empty list }">
							<h4 style="text-align:center; color : red;">이용이 제한된 사용자가 없습니다.</h4>
						</c:when>
						<c:otherwise>
							<table class="table table-hover" style="text-align:center;">
									<tr>
										<th>순번</th>
										<th>이용자</th>
										<th>학번</th>
										<th>제한 시작일</th>
										<th>제한 만료일</th>
										<th>사유</th>
										<th>해지/만료</th>
									</tr>
								<c:forEach items="${list }" var="list" varStatus="status">
									<tr>
										<td>${list.caNo }</td>
										<td>${list.meName }</td>
										<td>${list.meNo }</td>
										<td>${list.caStartStr }</td>
										<td>${list.caCloseStr }</td>
										<td>${list.caReason }</td>
										<td>
											<c:choose>
												<c:when test="${list.result == '해지' }">
													<input type="button" class="btn btn-primary btn-md btn-block" style="border: none; border-radius: 50px; background-color: purple;" onclick="return cancel(event, ${status.count})" value="${list.result }">
												</c:when>
												<c:otherwise>
													${list.result }
												</c:otherwise>
											</c:choose>
											<input type="hidden" id="caNo_${status.count}" value="${list.caNo }">
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
                        <p class="modal-title" style="font-size:25px;">Result</p>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        
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
	var str = "";
	var caNo = $("#caNo_"+idx).val();
	
	console.log(caNo);
	if(confirm("이용제한을 해지하시겠습니까?")){
		$.ajax({
			type : "post",
			url : "/caution/cancelCaution",
			data : {caNo : caNo},
			success : function(data){
				if(data == 'success'){
					
					location.reload();
					//alert("해지되었습니다.");
				}else{
					$(".modal").modal();
					$(".modal-body").empty();
					
					str += "<p>해지에 실패했습니다. 관리자에게 문의해주세요.</p>";
					
					$(".modal-body").append(str);
					//alert("해지에 실패했습니다. 관리자에게 문의해주세요.");
				}
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

