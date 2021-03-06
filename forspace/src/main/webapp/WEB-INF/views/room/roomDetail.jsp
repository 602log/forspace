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
#timeTable{
	text-align:center;
}
#timeTableTR{
	height:40px;
}
.timeTableTD{
	width:20%;
}
.timeTableTD2{
	cursor: pointer;
}

</style>
<%@ include file="../include/header.jsp"%>
<!-- Page content-->
<div class="container mt-5 main-content">
	<div class="row">
		<div class="col-lg-8">
			<div class="row">
				<div class="col-lg-6">
					<p style="font-size:25px;">연습실 상세정보</p>
					<div class="card shadow h-20 py-2 mb-4">
						<div class="card-body py-2">
							<div class="row no-gutters align-items-center">
								<div class="col">
									<div
										class="text-sm font-weight-bold text-primary text-uppercase mb-1">건물층</div>
									<div class="mb-0" style="font-size:20px;">${dto.roFloor }</div>
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
									<div class="mb-0" style="font-size:20px;">${dto.roMax }명까지</div>
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
									<div class="mb-0" style="font-size:20px;">${dto.roStart }~${dto.roClose }</div>
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
									<div class="mb-0" style="font-size:20px;">예약 1회당 ${dto.roLimit } 시간 이용가능</div>
								</div>
							</div>
						</div>
					</div>
				</div>


				<div class="col-lg-6">
					<p style="font-size:25px;">연습실 옵션</p>
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
												<div class="mb-0" style="font-size:20px;">${items.itemDTO.itName }
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
					<p style="font-size:25px;">불편사항</p>
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
										href="../room/roomDetail?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}&roNo=${roNo}">&lt;</a></li>
								</c:if>
								<c:forEach begin="${paging.startPage }" end="${paging.endPage }"
									var="p">
									<c:choose>
										<c:when test="${p == paging.nowPage }">
											<li class="page-item"><a class="page-link" href="#">${p }</a></li>
										</c:when>
										<c:when test="${p != paging.nowPage }">
											<li class="page-item"><a class="page-link"
												href="../room/roomDetail?nowPage=${p }&cntPerPage=${paging.cntPerPage}&roNo=${roNo}">${p }</a></li>
										</c:when>
									</c:choose>
								</c:forEach>
								<c:if test="${paging.endPage != paging.lastPage }">
									<li class="page-item"><a class="page-link"
										href="../room/roomDetail?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}&roNo=${roNo}">&gt;</a></li>
								</c:if>
							</ul>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>


<!-- 예약시간표 -->
		<div class="col-lg-4">
			<sec:authorize access="hasRole('ROLE_USER')">
				<button type="button" class="btn btn-primary btn-md btn-block" id="bookingBtn"
					style="border: none; border-radius: 50px; background-color: purple;" value="" onclick="return booking();">예약하기</button>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				<button type="button" class="btn btn-secondary btn-md btn-block" id="bookingBtn"
					style="border: none; border-radius: 50px; background-color: purple;" onclick="location.href='../room/modifyRoom?roNo=${dto.roNo}'">수정하기</button>		
			</sec:authorize>
				<br>
				<table class="table table-bordered" id="timeTable">
					<c:forEach begin="1" end="${diff }" var="i">
						<tr id="timeTableTR">
							<td class="timeTableTD" id="timeTableTD_${i }">${firstStartTime + (i-1)}:${scdStartTimeStr }</td>
							<td class="timeTableTD2" id="timeTableTD2_${i }" onclick="return selTime('${firstStartTime + (i-1)}:${scdStartTimeStr }', ${i });">
								<input type="hidden" value="N" id="tdInput_${i }" class="timeInput">
							</td>
						</tr>
					</c:forEach>
					<c:choose>
						<c:when test="${scdDiff == 30}">
							<tr id="timeTableTR">
								<td class="timeTableTD" id="timeTableTD_${diff.length+1 }">${firstCloseTime}:${scdStartTimeStr }</td>
								<td class="timeTableTD2" id="timeTableTD2_${diff.length+1 }" onclick="return selTime('${firstCloseTime}:${scdStartTimeStr }', ${diff.length+1 });">
									<input type="hidden" value="N" id="tdInput_${diff.length+1 }" class="timeInput">
								</td>
							</tr>
						</c:when>
					</c:choose>
				</table>
		</div>
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
        
        		<!-- message용 modal -->
        <div class="modal" tabindex="-1" role="dialog" id="msgModal">
            <div class="modal-dialog" role="document">
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
                        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="return reload();">Ok</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="return reload();">Close</button>
                    </div>
                </div>
            </div>
        </div>
        
<script>
$(document).ready(function(){
	$.ajax({
		url : "../booking/checkBook",
		type : "post",
		data : {roNo : ${dto.roNo }},
		success : function(data){
			$(data).each(function(){
					var rows = document.getElementById("timeTable").getElementsByTagName("tr");
					
					for(var r=0; r<rows.length; r++){
						var cells = rows[r].getElementsByTagName("td");
						var cell = cells[0].firstChild.data; //td의 값
						
						var boTime = this.boTime;
						if(boTime == cell){
							$("#timeTableTD2_"+(r+1)).css({
								"background-color":"gray"
							});
							$("#timeTableTD2_"+(r+1)).attr("onclick", "return false");
							//console.log(this.meEmail);
						}
					}

			});
		}
	});
	
});

$(document).on("click", "#complaintBtn", function(){
	//alert(${dto.roNo });
	//alert($("#coContent").val());
	
	var coContent = $("#coContent").val().length;
	var str = "";
	
	if($("#coContent").val() == "" && $("#coContent").val() == null && $("#coContent").val("")){
		$("#msgModal").modal();
		$("#msgBody").empty();
		str += "<p>불편사항을 입력해주세요.</p>";
		$("#msgBody").append(str);
		
		//alert("불편사항을 입력해주세요.");
		$("#coContent").focus();
	}else if(coContent > 50){
		
		$("#msgModal").modal();
		$("#msgBody").empty();
		str += "<p>50자 이내로 작성해주세요.</p>";
		$("#msgBody").append(str);
		
		//alert("50자 이내로 작성해주세요.");
		$("#coContent").focus();
	}else{
		$.ajax({
			url : "../complaint/insertComplaint",
			type : "post",
			data : {roNo : ${dto.roNo },
					coContent : $("#coContent").val()},
			success : function(data){
				if(data == 'success'){
					$("#comListDiv").load(window.location.href + " #comListDiv");
				}else{
					$("#msgModal").modal();
					$("#msgBody").empty();
					str += "<p>등록 실패했습니다.</p>";
					$("#msgBody").append(str);
					//alert("등록 실패했습니다.");
				}
			}
		});
	}

});

function cancelComp(coNo){
	//alert(${dto.roNo });
	//alert(coNo);
	var str="";
	var con_text = confirm("삭제하시겠습니까?");
	if(con_text == true){
		
		$.ajax({
			url : "../complaint/deleteComplaint",
			type : "post",
			data : {coNo : coNo,
					roNo : ${dto.roNo }},
			success : function(data){
				if(data == 'success'){
					$("#msgModal").modal();
					$("#msgBody").empty();
					str += "<p>삭제되었습니다.</p>";
					$("#msgBody").append(str);
					
					//alert("삭제되었습니다.");
					$("#comListDiv").load(window.location.href + " #comListDiv");
				}else{
					$("#msgModal").modal();
					$("#msgBody").empty();
					str += "<p>삭제에 실패했습니다.</p>";
					$("#msgBody").append(str);
					//alert("삭제에 실패했습니다.");
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
		url : "../complaint/FinishComplaint",
		type : "post",
		data : {coNo : coNo,
				roNo : ${dto.roNo}},
		success : function(data){
			if(data == 'success'){
				$("#comListDiv").load(window.location.href + " #comListDiv");
			}else{
				$("#msgModal").modal();
				$("#msgBody").empty();
				str += "<p>처리에 실패했습니다. 나중에 다시 시도해주세요.</p>";
				$("#msgBody").append(str);
				
				//alert("처리에 실패했습니다. 나중에 다시 시도해주세요.");
			}
		}
	});
}

function selTime(time, idx){
	//alert(time);
	//alert(idx);

	var roLimit = ${dto.roLimit}
	var plusMax = ${dto.roLimit}-1;
	//alert(${dto.roMax});
	//alert(plusMax);
	
	var btnVal = $("#bookingBtn").val();
	//alert(btnVal);
	
	if(btnVal == "" || btnVal == null){//클릭한 적 없을 때
		//이용제한시간에 따른 클릭
	 	if(plusMax == 0){//이용제한시간이 1시간일 때
			//alert("0으로 옴");
			
			//선택한 칸 색상 바꾸기
			$("#timeTableTD2_"+idx).css({
				"background-color":"purple"
			});
			//선택한 칸 value Y로 변경
			$("#tdInput_"+idx).attr("value", "Y");
			//선택한 시간(예약시작시간)을 button value로 설정
			$("#bookingBtn").attr("value", time);

		}else{
			//이용제한 시간이 2시간 이상일때
			for(i=0; i<roLimit; i++){
				if($("#timeTableTD2_"+(idx+i)).attr('style') == undefined || $("#timeTableTD2_"+(idx+i)).attr('style') == ""){
					//선택한 칸 + 이용제한시간까지 색상 바꾸기
					$("#timeTableTD2_"+(idx+i)).css({
						"background-color":"purple"
					});
					//선택한 칸 value Y로 변경
					$("#tdInput_"+(idx+i)).attr("value", "Y");
					//선택한 시간(예약시작시간)을 button value로 설정
					$("#bookingBtn").attr("value", time);
				}else if($("#timeTableTD2_"+(idx+i)).attr('style') == 'gray'){
					$("#bookingBtn").attr("value", time);
				}

			}//end of for
		}
		
	}else{//클릭한 적 있을 때
		
		for(var i=1; i<=${diff+1}; i++){
			if($('#tdInput_'+i).attr('value') == 'Y'){
				$("#timeTableTD2_"+i).css({
					"background-color":""
				});
			}
		}
	
		$(".timeInput").attr("value", "N");
/* 		$(".timeInput").attr("value", "");		
		$(".timeTableTD2").css({
			"background-color":""
		}); */
		//이용제한시간에 따른 클릭
	 	if(plusMax == 0){
			//alert("0으로 옴");
			
			//선택한 칸 색상 바꾸기
			$("#timeTableTD2_"+idx).css({
				"background-color":"purple"
			});
			//선택한 칸 value Y로 변경
			$("#tdInput_"+idx).attr("value", "Y");
			//선택한 시간(예약시작시간)을 button value로 설정
			$("#bookingBtn").attr("value", time);

		}else{
			//alert("else로 옴");

			for(i=0; i<roLimit; i++){
				
				if($("#timeTableTD2_"+(idx+i)).attr('style') == undefined || $("#timeTableTD2_"+(idx+i)).attr('style') == ""){
					//선택한 칸 + 이용제한시간까지 색상 바꾸기
					$("#timeTableTD2_"+(idx+i)).css({
						"background-color":"purple"
					});
					//선택한 칸 value Y로 변경
					$("#tdInput_"+(idx+i)).attr("value", "Y");
					//선택한 시간(예약시작시간)을 button value로 설정
					$("#bookingBtn").attr("value", time);
				}else if($("#timeTableTD2_"+(idx+i)).attr('style') == 'gray'){
					$("#bookingBtn").attr("value", time);
				}
			}//end of for
		}	
	
	}//end of if
}//end of selTime()

function booking(){
	var seltime = $("#bookingBtn").val();
	var roNo = ${dto.roNo};
	var roLimit = ${dto.roLimit};
	var scNo = ${dto.scNo}
	//alert("예약하기"+seltime);
	
 	$.ajax({
		type : "post",
		url : "../booking/insertbook",
		data : {roNo : roNo,
				boTime : seltime,
				roLimit : roLimit,
				scNo : scNo},
		success : function(data){
			var msg = "";
			var str = "";
			if(data == 'success'){
				msg = '예약되었습니다.';
			}else if(data == 'already'){
				msg = '이미 예약하셨습니다.';
			}else if(data == 'dont'){
				msg = '이용이 제한된 사용자입니다.';
			}
			$("#msgModal").modal();
			$("#msgBody").empty();
			str += "<p>"+msg+"</p>";
			$("#msgBody").append(str);
			}
				
		});
}

function reload(){
	location.reload();
}
</script>
<%@ include file="../include/footer.jsp"%>

