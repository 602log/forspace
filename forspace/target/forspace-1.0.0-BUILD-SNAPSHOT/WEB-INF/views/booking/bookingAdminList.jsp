<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
.card-title{
font-size:20px;
}
.card-text{
font-size:20px;
}
</style>
<%@ include file="../include/header.jsp"%>
        <!-- Page content-->
       	<div class="container main-container">

		       	<div class="col-12 mb-3">
					<p style="font-size:25px;">예약확인<p>
					<br>
					<c:choose>
						<c:when test="${empty list }">
							<p style="font-size:25px; text-align:center; color : red;">예약된 기록이 없습니다.</p>
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
									<tr id="profileTr">
										<td>${list.boDateStr }</td>
										<td><input type="button" class="btn btn-outline-light text-dark" onclick="return profileTr(${status.count});" value="${list.meName }"></td>
										<td>${list.roName }</td>
										<td>${list.boTime }</td>
										<td>
											<c:choose>
												<c:when test="${list.refused == '취소' }">
													<input type="button" class="btn btn-primary btn-md btn-block" style="border: none; border-radius: 50px; background-color: purple;" onclick="return cancel(event, ${status.count})" value="${list.refused }">
												</c:when>
												<c:otherwise>
													${list.refused }
												</c:otherwise>
											</c:choose>
											<input type="hidden" id="roNo_${status.count}" value="${list.roNo }">
											<input type="hidden" id="meEmail_${status.count}" value="${list.meEmail}">
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
										href="../booking/bookingAdminList?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&lt;</a></li>
								</c:if>
								<c:forEach begin="${paging.startPage }" end="${paging.endPage }"
									var="p">
									<c:choose>
										<c:when test="${p == paging.nowPage }">
											<li class="page-item"><a class="page-link" href="#">${p }</a></li>
										</c:when>
										<c:when test="${p != paging.nowPage }">
											<li class="page-item"><a class="page-link"
												href="../booking/bookingAdminList?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a></li>
										</c:when>
									</c:choose>
								</c:forEach>
								<c:if test="${paging.endPage != paging.lastPage }">
									<li class="page-item"><a class="page-link"
										href="../booking/bookingAdminList?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&gt;</a></li>
								</c:if>
							</ul>
						</c:otherwise>
					</c:choose>
       	</div>
       	
       	<!-- modal -->
        <div class="modal" tabindex="-1" role="dialog" id="proModal">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                    	<p class="modal-title" style="font-size:25px;">Profile</p>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" id="modal-body">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- modal -->
        <div class="modal" tabindex="-1" role="dialog" id="msgModal">
            <div class="modal-dialog msgModal" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <p class="modal-title" style="font-size:25px;">Result</p>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" id="msgBody">
                       
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
			url : "../booking/cancelBooking",
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

function profileTr(idx){
	
	$("#proModal").modal();
	var meEmail = $("#meEmail_"+idx).val();
	
	$.ajax({
		type : "post",
		url : "../member/findMember",
		data : {meEmail : meEmail},
		dataType : "json",
		success : function(data){
			$("#modal-body").empty();
			var str = "";
			var dto = data;
				if(dto.imageDTO == null){
					str += "<div class='card' style='text-align:center;'>"
						+ "<div class='card-body'>"
						+ "<h4 class='card-title'>"+dto.meName+"</h4>"
						+ "<p class='card-text'>"
						+ "<a href='#' class='img logo rounded-circle'>"
						+ "<img id='img' src='../resources/images/user.png' alt='profile'>"
						+ "</a>"
						+ "</p>"
						+ "<p class='card-text'>"+dto.meNo+"</p>"
						+ "<p class='card-text'>"+dto.meEmail+"</p>"
						+ "<hr>"
						+ "<p class='card-text'>이용제한사유</p>"
						+ "<p class='card-text'>"
						+ "<input type='text' class='form-control' id='caReason' placeholder='30자 이내로 작성해주세요.'>"
						+ "</p>"
						+ '<input type="button" class="btn btn-primary btn-md btn-block" style="border: none; border-radius: 50px; background-color: purple;" onclick="return limited(\''+dto.meEmail+'\');" value="이용제한">'
						+ "</div>"
						+ "</div>";
				}else{
					str += "<div class='card' style='text-align:center;'>"
						+ "<div class='card-body'>"
						+ "<p class='card-title'>"+dto.meName+"</p>"
						+ "<p class='card-text'>"
						+ "<a href='#' class='img logo rounded-circle'>"
						+ "<img id='img' src='../image/show?imagePath="+dto.imageDTO.imagePath+"' alt='profile'>"
						+ "</a>"
						+ "</p>"
						+ "<p class='card-text'>"+dto.meNo+"</p>"
						+ "<p class='card-text'>"+dto.meEmail+"</p>"
						+ "<hr>"
						+ "<p class='card-text'>이용제한사유</p>"
						+ "<p class='card-text'>"
						+ "<input type='text' class='form-control' id='caReason' placeholder='30자 이내로 작성해주세요.'>"
						+ "</p>"
						+ '<input type="button" class="btn btn-primary btn-md btn-block" style="border: none; border-radius: 50px; background-color: purple;" onclick="return limited(\''+dto.meEmail+'\');" value="이용제한">'
						+ "</div>"
						+ "</div>";
				}

			$("#modal-body").append(str);
		},
		error : function(){
			
		}
	});
}

function limited(meEmail){
	var caReason = $("#caReason").val();
	var str = "";
	console.log(caReason);
	if(caReason.length>30 || caReason.length<1){
		$("#caReason").css({"border" : "solid 2px", "border-color" : "red"});
		setTimeout(function() { 
			$("#caReason").css({"border-color": ""});	
			}, 1000);
		return false;
		}
	
		$.ajax({
			type : "post",
			url : "../caution/insCaution",
			data : {meEmail : meEmail,
					caReason : caReason},
			success : function(data){
				if(data == 'success'){
					$("#msgModal").modal();
					$("#msgBody").empty();
					
					str += "<p>이용이 제한되었습니다.</p>";
					
					$("#msgBody").append(str);
					$("#caReason").val("");
					//alert('이용이 제한되었습니다.');
				}else{
					$("#msgModal").modal();
					$("#msgBody").empty();
					
					str += "<p>이미 제한된 이용자입니다.</p>";
					
					$("#msgBody").append(str);
					$("#caReason").val("");
					//alert('이미 제한된 이용자입니다.');
				}
			}, error : function(){
				
			} 
		});
	
};
</script>
	<%@ include file="../include/footer.jsp"%>

