<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.policy-table {
	color: grey;
	text-align: center;
}

.headings, .policy {
	display: -webkit-box;
	display: -ms-flexbox;
	display: flex;
	-webkit-box-pack: justify;
	-ms-flex-pack: space-between;
	margin-bottom: 0.5em;
	padding: 0.5em;
}

.policy {
	border-radius: 0.5em;
	background-color: white;
	margin-bottom: 10px;
	-moz-box-shadow: 0 0 1px grey;
	-webkit-box-shadow: 0 0 1px grey;
	box-shadow: 0 0 5px grey;
}

#span1 {
	flex-basis: 10%;
}

#span2 {
	flex-basis: 70%;
}

#span3 {
	flex-basis: 20%;
}
a {
	text-decoration: none;
	color: #4c4c4c;
}
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
									<div
										class="text-sm font-weight-bold text-primary text-uppercase mb-1">건물층</div>
									<div class="h5 mb-0">${dto.roFloor }</div>
								</div>
							</div>
						</div>
					</div>



					<div class="card shadow h-20 py-2 mb-4">
						<div class="card-body py-2">
							<div class="row no-gutters align-items-center">
								<div class="col">
									<div
										class="text-sm font-weight-bold text-primary text-uppercase mb-1">최대수용인원</div>
									<div class="h5 mb-0">${dto.roMax }명까지</div>
								</div>
							</div>
						</div>
					</div>



					<div class="card shadow h-20 py-2 mb-4">
						<div class="card-body py-2">
							<div class="row no-gutters align-items-center">
								<div class="col">
									<div
										class="text-sm font-weight-bold text-primary text-uppercase mb-1">이용가능시간</div>
									<div class="h5 mb-0">${dto.roStart }~${dto.roClose }</div>
								</div>
							</div>
						</div>
					</div>

					<div class="card shadow h-20 py-2 mb-4">
						<div class="card-body py-2">
							<div class="row no-gutters align-items-center">
								<div class="col">
									<div
										class="text-sm font-weight-bold text-primary text-uppercase mb-1">기본예약시간</div>
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
												<div class="h5 mb-0">${items.itemDTO.itName }
													${items.riCnt}개</div>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>

				<!-- complaint list-->
				<div class="col-lg-12 policy-container" style="padding-top: 30px;" id="comListDiv">
					<h3>불편사항</h3>
					<div class="policy-table">
						<div class="headings">
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<span class="heading" id="span1">요청처리</span>
							</sec:authorize>
							<sec:authorize access="hasRole('ROLE_USER')">
								<span class="heading" id="span1">삭제</span>
							</sec:authorize>
							<span class="heading" id="span2">내용</span> 
							<span class="heading" id="span3">처리완료</span>
						</div>
						<c:choose>
							<c:when test="${empty com }">
								<div class="policy">
									<span style="color: red; flex-basis: 50%;">등록된 내용이 없습니다.</span>
								</div>
							</c:when>
							<c:otherwise>
								<c:forEach var="com" items="${com }">
									<div class="policy">
									
										<sec:authorize access="hasRole('ROLE_ADMIN')">
											<span id="span1">
												<input type="button" class="btn btn-primary btn-sm btn-block" id="comfinish" value="처리" 
													style="border: none; border-radius: 15px; background-color: purple;"
													onclick="comFinish(${com.coNo})">
											</span>
										</sec:authorize>
										
										<sec:authorize access="hasRole('ROLE_USER')">
										<sec:authentication property="principal.memberDTO.meEmail" var="meEmail"/>
										<c:choose>
											<c:when test="${meEmail == com.meEmail}">
												<span id="span1">
													<input type="button" class="btn btn-primary btn-sm btn-block" value="삭제" 
														style="border: none; border-radius: 15px; background-color: purple;"
														onclick="cancelComp(${com.coNo})">
												</span>
											</c:when>
											<c:otherwise>
												<span id="span1"></span>
											</c:otherwise>
										</c:choose>
										</sec:authorize>
										
										
											<span id="span2" style="text-align:left; margin-left:10px;">${com.coContent }</span>
											
											
										<c:choose>
											<c:when test="${com.coFinish == '' || com.coFinish == null }">
												<span id="span3">미처리</span>
											</c:when>
											<c:otherwise>
												<span id="span3">처리완료</span>
											</c:otherwise>
										</c:choose>
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>

					<!-- insert complaint -->
					<table id="comTable" style="width: 100%;">
						<tr>
							<td style="width: 90%;">
								<input type="text" class="form-control form-control-lg" id="coContent"></td>
							<td style="width: 10%;">
								<input type="button" class="btn btn-primary btn-md btn-block" id="complaintBtn"
								value="등록" style="border: none; border-radius: 15px; background-color: purple; margin-left: 3px;">
							</td>
						</tr>
					</table>

					<br>
					<br>
					<!-- pagination -->
					<c:choose>
						<c:when test="${paging.total <6}">
							<ul></ul>
						</c:when>
						<c:otherwise>
							<ul class="pagination pagination-sm"
								style="justify-content: center;">
								<c:if test="${paging.startPage != 1}">
									<li class="page-item"><a class="page-link"
										href="/room/roomDetail?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}&roNo=${roNo}">&lt;</a></li>
								</c:if>
								<c:forEach begin="${paging.startPage }" end="${paging.endPage }"
									var="p">
									<c:choose>
										<c:when test="${p == paging.nowPage }">
											<li class="page-item"><a class="page-link" href="#">${p }</a></li>
										</c:when>
										<c:when test="${p != paging.nowPage }">
											<li class="page-item"><a class="page-link"
												href="/room/roomDetail?nowPage=${p }&cntPerPage=${paging.cntPerPage}&roNo=${roNo}">${p }</a></li>
										</c:when>
									</c:choose>
								</c:forEach>
								<c:if test="${paging.endPage != paging.lastPage }">
									<li class="page-item"><a class="page-link"
										href="/room/roomDetail?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}&roNo=${roNo}">&gt;</a></li>
								</c:if>
							</ul>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>


<!-- 예약시간표 -->
		<div class="col-lg-4" style="background-color: yellow;">
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<button type="button" class="btn btn-secondary btn-md btn-block"
					style="border: none; border-radius: 50px; background-color: purple;">수정하기</button>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_USER')">
				<button type="button" class="btn btn-primary btn-md btn-block"
					style="border: none; border-radius: 50px; background-color: purple;">예약하기</button>
			</sec:authorize>
			
			<table>
				<c:forEach begin="1" end="${diff }">
					<tr style="background-color:red;">
						<td>입력</td>
						<td>입력</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>

</div>
<script>
$(document).on("click", "#complaintBtn", function(){
	//alert(${dto.roNo });
	//alert($("#coContent").val());
	
	var coContent = $("#coContent").val().length
	
	if($("#coContent").val() == "" && $("#coContent").val() == null && $("#coContent").val("")){
		alert("불편사항을 입력해주세요.");
		$("#coContent").focus();
	}else if(coContent > 50){
		alert("50자 이내로 작성해주세요.");
		$("#coContent").focus();
	}else{
		$.ajax({
			url : "/complaint/insertComplaint",
			type : "post",
			data : {roNo : ${dto.roNo },
					coContent : $("#coContent").val()},
			success : function(data){
				if(data == 'success'){
					$("#comListDiv").load(window.location.href + " #comListDiv");
				}else{
					alert("등록 실패했습니다.");
				}
			}
		});
	}

});

function cancelComp(coNo){
	//alert(${dto.roNo });
	//alert(coNo);
	
	var con_text = confirm("삭제하시겠습니까?");
	if(con_text == true){
		
		$.ajax({
			url : "/complaint/deleteComplaint",
			type : "post",
			data : {coNo : coNo,
					roNo : ${dto.roNo }},
			success : function(data){
				if(data == 'success'){
					alert("삭제되었습니다.");
					$("#comListDiv").load(window.location.href + " #comListDiv");
				}else{
					alert("삭제에 실패했습니다.");
				}
			}
		});
		
	}else{
		return false;
	}
	
}

function comFinish(coNo){
	
	var comfinish = $("#comfinish");
	
	$.ajax({
		url : "/complaint/FinishComplaint",
		type : "post",
		data : {coNo : coNo,
				roNo : ${dto.roNo}},
		success : function(data){
			if(data == 'success'){
				$("#comListDiv").load(window.location.href + " #comListDiv");
			}else{
				alert("처리에 실패했습니다. 나중에 다시 시도해주세요.");
			}
		}
	});
}
</script>

<%@ include file="../include/footer.jsp"%>

