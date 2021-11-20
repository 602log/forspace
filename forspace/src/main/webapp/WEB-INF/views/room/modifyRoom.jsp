<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.limitTime{
		float:left;
	}
	.modalBtn{
		color:purple;
	}
	.modalBtn:hover {
	  color: #939597;
	}
	.buttons{
	width : 300px;
	}
</style>
<%@ include file="../include/header.jsp"%>
        <!-- Page content-->
        <div class="container mt-5 main-content">
        	<form action="/room/modify" method="post" id="modifyFrm">
	        	<div class="row">
	                <div class="col-lg-6"> 
						<label>건물층</label>
						<div class="form-group form-default">
							<input type="number" name="roFloor" id="roFloor" class="form-control" value="${dto.roFloor }">
						</div>
						<label>연습실 이름</label>
						<div class="form-group form-default">
							<input type="text" name="roName" id="roName" class="form-control" value="${dto.roName }">
						</div>
						<label>최대 수용인원</label>
						<div class="form-group form-default">
							<input type="number" name="roMax" id="roMax" class="form-control" min="1" value="${dto.roMax }">
						</div>
						<label>1회당 이용가능시간</label>
						<div class="form-group form-default">
							<input type="number" name="roLimit" id="roLimit" class="form-control" min="1" value="${dto.roLimit }">
						</div>
						<label>운영시간</label>
						<div class="form-group form-default">
							<table style="width:100%;">
								<tr>
									<td><input type="text" name="roStart" id="roStart" class="form-control" value="${dto.roStart }"></td>
									<td>~</td>
									<td><input type="text" name="roClose" id="roClose" class="form-control" value="${dto.roClose }"></td>
								</tr>
							</table>
						</div>
	                </div>
	                
	                <div class="col-lg-6">
						<label>옵션 <i role="button" class="fas fa-plus-circle modalBtn"></i></label>
						<div  class="form-group form-default" id="selItem"></div>
						<input type="hidden" id="itemCheckCnt" value="0">
	                </div>
	                
	                
	                <input type="hidden" name="roNo" id="roNo" class="form-control" value="${dto.roNo }">
	                <input type="hidden" name="scNo" id="scNo" class="form-control" value="${dto.scNo }">
				</div>
				
				<div align="center" class="rows" id="btns">
					<div class="col-6 mt-1">
						<input type="submit" id="submit" name="submit" class="btn btn-primary buttons" value="수정">
					</div>
					<div class="col-6 mt-1">
						<input type="button" id="delete" class="btn btn-danger buttons" onclick="return false;" value="삭제하기" >
					</div>
					<div class="col-6 mt-1">
						<input type=button id="cancel" name="cancel" class="btn btn-secondary buttons" value="취소">
					</div>
				</div>
			</form>			
        </div>
        
        
        <!-- modal -->
			<div class="modal" id="itemModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">연습실 옵션 추가</h5>
							<button class="close" type="button" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">
							<label>옵션</label>
							<div class="input-group mb-3">
								<input type="text" class="form-control searchInput" aria-describedby="btnAddon">
								<button class="btn btn-outline-secondary itemSearch" type="button" id="btnAddon"><i class="fa fa-search"></i></button>
							</div>
							<div class="input-group mb-3" id="getResultItem"></div>
							<div id="itemCnt"></div>
						</div>
						<div class="modal-footer">
							<a class="btn btn-primary" id="itemAddBtn">추가</a>
						</div>
					</div>
				</div>
					
			</div>
<script>
$(document).ready(function(){
	
	$.ajax({
		type : "post",
		url : "/room/findItem",
		data : {roNo : ${dto.roNo }},
		dataType : "json",
		success : function(data){
			var str = "";
			var count = 1;
			var items = data;
			//console.log(items[3].itNo);
			if(data.length>0){
				for(var i=0; i<data.length; i++){
					var str = "<div class='input-group mb-3 itemListDiv'>"
						+ "<input type='text' class='form-control' aria-describedby='btnAddon"+count+"' value='"+items[i].itemDTO.itName+" ("+items[i].riCnt+"개)' readonly disabled>"
						+ "<button class='btn btn-outline-secondary delItem' type='button'>"
						+ "<i class='fas fa-minus'>"
						+ "</i>"
						+ "</button>"
						+ "<input type='hidden' class='form-control' id='itNo' name='itNo' value='"+items[i].itNo+"'>"
						+ "<input type='hidden' class='form-control' id='riNo' name='riNo' value='"+items[i].riNo+"'>"
						+ "<input type='hidden' class='form-control' id='riCnt' name='riCnt' value='"+items[i].riCnt+"'>"
						+ "</div>"
					$("#selItem").append(str);
				}//end of for
			}//end of if

		}
		
	});

	$("input#roStart").timepicker({
		timeFormat : "HH:mm",
		interval : 30,
		startTime : "00:00",
		dynamic : false,
		dropdown : true,
		scrollbar : true
	});
	
	$("input#roClose").timepicker({
		timeFormat : "HH:mm",
		interval : 30,
		startTime : "00:00",
		dynamic : false,
		dropdown : true,
		scrollbar : true
	});
	
	$("#cancel").on("click", function(){
		location.href="../room/roomList?roFloor=0";
	});
	
	$("#delete").on("click", function(){
		var roNo = $("#roNo").val();
		location.href="../room/deleteRoom?roNo="+roNo
	});
	
	$("#submit").on("click", function(){
		
		if($("#roFloor").val() == 0 || $("#roFloor").val() == ""){
			alert("정확한 층수를 입력해주세요.");
			$("#roFloor").focus();
			return false;
		}
		if($("#roName").val() == ""){
			alert("연습실 이름을 입력해주세요.");
			$("#roName").focus();
			return false;
		}
		if($("#roMax").val() == 0 || $("#roMax").val() == ""){
			alert("최대 수용인원을 입력해주세요.");
			$("#roMax").focus();
			return false;
		}
		if($("#roLimit").val() == 0 || $("#roLimit").val() == ""){
			alert("예약 1회당 이용 가능시간을 입력해주세요.");
			$("#roLimit").focus();
			return false;
		}
		if($("#roStart").val() == ""){
			alert("오픈 시간을 입력해주세요.");
			$("#roStart").focus();
			return false;
		}
		if($("#roClose").val() == ""){
			alert("마감 시간을 입력해주세요.");
			$("#roClose").focus();
			return false;
		}
		
		var roStartStr = $("#roStart").val();
		var roCloseStr = $("#roClose").val();
		
		if(roStartStr != roCloseStr){
			 var roStartSplit = roStartStr.split(":");
			 var roCloseSplit = roCloseStr.split(":");
			 
			 //alert(roStartSplit[0] + roCloseSplit[0]);
			 var roStartFirstInt = parseInt(roStartSplit[0]);
			 var roCloseFirstInt = parseInt(roCloseSplit[0]);
			 
			 var roStartScdInt = parseInt(roStartSplit[1]);
			 var roCloseScdInt = parseInt(roCloseSplit[1]);

			 
			 if(roStartFirstInt > roCloseFirstInt){//오픈의 시가 클 경우
				alert("마감시간보다 오픈시간이 빠릅니다. 다시 설정해주세요.");
			 	console.info("오픈의 시가 클 경우"+roStartFirstInt+" "+roCloseFirstInt);
				return false;
				
			 }else if(roStartFirstInt == roCloseFirstInt){//오픈과 마감의 시가 같을 경우
				 
				 //분을 비교
				 if(roStartScdInt > roCloseScdInt){//시는 같고 분은 오픈이 클 경우
					 alert("마감시간보다 오픈시간이 빠릅니다. 다시 설정해주세요.");
					 console.info("시는 같고 분이 오픈이 클 경우"+roStartFirstInt+" "+roCloseFirstInt);
					 return false;
				 }else if(roStartScdInt < roCloseScdInt){//오픈과 마감이 한시간 이내
					 alert("오픈시간과 마감시간이 한 시간 이내입니다. 다시 설정해주세요.");
					 return false;
				 }
			 
			 }else if(roStartFirstInt < roCloseFirstInt){//마감 시가 클 경우

			 }

		}else if(roStartStr == roCloseStr){
			alert("운영시간을 정확히 설정해주세요.");
			$("#roClose").focus();
			return false;
		}
		
		$("#modifyFrm").submit();
	});
	
	$(".modalBtn").on('click', function(){
		$("#itemModal").modal();
		$("#getResultItem").empty();
		$("#itemCnt").empty();
		$("#itemAddBtn").hide();
		$(".searchInput").val("");
	});
	
	$(".itemSearch").on("click", function(){
		var items = $(".searchInput").val();
		var str = "";
		
		$("#getResultItem").empty();
		$("#itemCnt").empty();
		$("#itemAddBtn").hide();
		
		$.ajax({
			type : "post",
			url : "/room/searchItem",
			data : {itName : items},
			dataType : "json",
			success : function(data){
				var cnt = 1;
				if(data.length>0){
					$.each(data, function(index, items){
						str += "<div class='input-group mb-3'>"
							+ "<input type='text' class='form-control' aria-describedby='btnAddon"+cnt+"' value='"+items.itName+"' readonly>"
							+ "<input type='hidden' class='form-control' id='selItNo' value='"+items.itNo+"' readonly>"
							+ "<input type='hidden' class='form-control' id='selItName' value='"+items.itName+"' readonly>"
							+ "<button class='btn btn-outline-secondary' type='button' id='btnAddon"+cnt+"'>"
							+ "<i class='fas fa-check'>"
							+ "</i>"
							+ "</button>"
							+ "</div>";
						cnt++;
					});
					$("#getResultItem").append(str);
				}else{
					str += "<div class='input-group mb-3'>" 
						+ "<input type='text' class='form-control' value='검색 결과가 없습니다' disabled readonly>" 
						+ "</div>";
					$("getResultItem").append(str);
				}
			},
			error : function(){
				
			}
		});
	});
	
	$("#getResultItem").on("click", "button", function(){
		var str = "";
		$(this).attr("class", "btn btn-outline-success");
		var check = $(this).closest("div").clone();
		$("#itemCnt").empty();
		$("#getResultItem").empty();
		$("#getResultItem").append(check);
		str += "<label>개수</label>"
			+ "<input type='number' id='itemSelCnt' class='form-control' min='1'>";
		$("#itemCnt").append(str);
		$("#itemAddBtn").show();
	});
	
	var count = 1;
	var itCheckCnt = 0;
	
	$("#itemAddBtn").on("click", function(){
		var itNo = $("#selItNo").val();
		var itName = $("#selItName").val();
		var riCnt = $("#itemSelCnt").val();
		if(riCnt>=1 && !!riCnt){
			var str = "<div class='input-group mb-3 itemListDiv'>"
					+ "<input type='text' class='form-control' aria-describedby='btnAddon"+count+"' value='"+itName+" ( "+riCnt+"개 )' readonly disabled>"
					+ "<button class='btn btn-outline-secondary delItem' type='button'>"
					+ "<i class='fas fa-minus'>"
					+ "</i>"
					+ "</button>"
					+ "<input type='hidden' class='form-control' name='itNo' value='"+itNo+"'>"
					+ "<input type='hidden' class='form-control' name='riCnt' value='"+riCnt+"'>"
					+ "</div>"
			$("#selItem").append(str);
			$("#itemModal").modal('hide');
			
			itCheckCnt++;
			
			$("#itemCheckCnt").val(itCheckCnt);
			count++;
		}else{
			$("#itemSelCnt").css({"border" : "solid 2px", "border-color" : "red"});
			setTimeout(function(){
				$("itemSelCnt").css({"border-color" : ""});
			}, 1000);
		}
	});
	
	$("#selItem").on("click", "button", function(){
		$(this).closest("div").remove();
		itCheckCnt--;
		$("#itemCheckCnt").val(itCheckCnt);
	})

});

</script>
	<%@ include file="../include/footer.jsp"%>

