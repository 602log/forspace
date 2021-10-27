<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	.modalBtn{
		color : purple;
	}
	
	#emailBlock{
		display : flex;
	}
	#firstDIV{
		width : 65%;
		margin : 0 10px 0 0;
	}
</style>
<%@ include file="../include/header.jsp"%>
        
        <div class="container mt-5 main-content">
        <form class="form-material" method="post" id="joinFrm" action="/member/memberjoin" enctype="multipart/form-data">
			<div class="row">
				
				    <div class="col-lg-6"> 
						<label>프로필</label>
						<div class="form-group form-default">
							<input type="file" class="form-control form-control-user inputImg" name="image">
						</div>	
	                </div>
	                <div class="col-lg-6">
						<label>소속 기관 <i role="button" class="fas fa-plus-circle modalBtn"></i></label>
						<div class="form-group form-default" id="selSchool"></div>
						<input type="hidden" value="0" id="schCheckCnt">
						
						<label>이메일</label>
						<div class="form-group form-default" id="emailBlock">
							<div id="firstDIV">
								<input type="text" name="meEmail" id="meEmail" class="form-control" placeholder="이메일 형태로 입력해주세요(abc@***.com)">
							</div>
							<div id="secondDIV">
								<button type="button" value="N" id="emailCheckBtn" name="emailCheckBtn" class="btn btn-primary" style="border-radius: 30px;" onclick="emailCheck()">이메일중복확인</button>
							</div>
						</div>
						
						<label>비밀번호</label>
						<div class="form-group form-default">
							<input type="password" name="mePwd" id="mePwd" class="form-control">
						</div>
						
						<label>비밀번호 확인</label>
						<div class="form-group form-default">
							<input type="password" name="mePwdCheck" id="mePwdCheck" class="form-control">
						</div>
						
						<label>이름</label>
						<div class="form-group form-default">
							<input type="text" name="meName" id="meName" class="form-control">
						</div>
						
						<label>학번</label>
						<div class="form-group form-default">
							<input type="text" name="meNo" id="meNo" class="form-control">
						</div>
						<input type="hidden" name="meRole" id="meRole" value="USER">
                	</div>
                
			</div>
				
				<div class="mt-5" align="center">
					<input type="submit" id="submit" name="submit" class="btn btn-primary" value="가입">
					<input type=button id="cancel" name="cancel" class="btn btn-danger" value="취소"><!-- 홈화면으로 돌아가기 (학생, 교직원 선택하는 화면)-->
				</div>
			
       </form> 
        </div>

        
<!-- Modal -->
        
        <div class="modal" id="schoolModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        	<div class="modal-dialog" role="document">
        		<div class="modal-content">
        			<div class="modal-header">
        				<h5 class="modal-title" id="exampleModalLabel">소속 기관</h5>
        				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
        					<span aria-hidden="true">×</span>
        				</button>
        			</div>
        			<div class="modal-body">
        				<div class="input-group mb-3">
        					<input type="text" class="form-control searchInput" aria-describedby="selectBtn">
        					<button class="btn btn-outline-secondary schoolSearch" type="button" id="selectBtn"><i class="fa fa-search"></i></button>
        				</div>
        				<div class="input-group mb-3" id="getResult"></div>
        				<div id="schCheckNum"></div>
        			</div>
        			<div class="modal-footer">
        				<a class="btn btn-primary" id="schoolSelBtn">선택</a>
        			</div>
        		</div>
        	</div>        
        </div>
        
<script>

	$(document).ready(function(){
		$("#cancel").on("click", function(){
			location.href="/";
		});
		
		$("#submit").on("click", function(){
			
			var mePwd = $("#mePwd").val();
			var mePwdCheck = $("#mePwdCheck").val();
			var cnt = $("#schCheckCnt").val();//소속기관 선택	
	
				if(cnt < 1){
					alert("소속 기관을 선택해주시기 바랍니다.");
					$(".modalBtn").css({"color": "red"});	
					setTimeout(function() { 
						$(".modalBtn").css({"color": ""});	
						}, 1000);
					return false;
				}
			
				if($("#meEmail").val() == ""){
					alert("이메일을 입력해주세요.");
					$("#meEmail").focus();
					return false;
				}
				
				
				if($("#mePwd").val() == "" || mePwd.length<8 || mePwd.length>15){
					
					alert("비밀번호는 8~15자 사이로 입력해주시기 바랍니다.");
					$("#mePwd").focus();
					return false;
				}
				
				if($("#mePwdCheck").val() == "" || mePwd != mePwdCheck){
					alert("비밀번호가 일치하지 않습니다.");
					$("#mePwdCheck").focus();
					return false;
				}
				
				if($("#meName").val() == ""){
					alert("이름을 입력해주시기 바랍니다.");
					$("#meName").focus();
					return false;
				}
				
				if($("#meNo").val() == ""){
					alert("학번을 입력해주시기 바랍니다.");
					$("#meNo").focus();
					return false;
				}
				
				var emailCheckVal = $("#emailCheckBtn").val();
				
				if(emailCheckVal == "N" ){
					
					alert("중복확인버튼을 눌러주세요.");
					return false;
					
				}else if(emailCheckVal == "Y"){
					$("#joinFrm").submit();
				}

		});
	});

	function ECheck(email){
		var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		return (email != '' && email != 'undefined' && regex.test(email));
	}//ECheck() end
	
	function emailCheck(){
		
		
		if(! (ECheck($("#meEmail").val()))){
			alert("올바른 이메일을 입력해주세요.");
			return false;
		}
		
		$.ajax({
			url : "/member/emailCheck",
			type : "post",
			data : {"meEmail" : $("#meEmail").val()},
			success : function(data){
				console.log(data)
				
				if(data == 'success'){
					$("#emailCheckBtn").attr("value", "Y");
					alert("사용 가능한 아이디 입니다.");
				}else{
					alert("중복된 아이디 입니다.");
					return false;
				}
			}
		});
	}
	
	$(".modalBtn").on("click", function(){
		//alert("클릭함");
		$("#schoolModal").modal();
		$("#getResult").empty();
		$("#schCheckNum").empty();
		$("#schoolSelBtn").hide();
		$(".searchInput").val("");
	});
	
	$(".schoolSearch").on("click", function(){

		var sch = $(".searchInput").val();
		var str = "";
		$("#getResult").empty();
		$("#schCheckNum").empty();
		$("#schoolSelBtn").hide();
		$.ajax({
			type: "post",
			url: "/member/searchSch",
			data:{ scName : sch },
			dataType: "json",
			success: function(data){
				var cnt = 1;
				if(data.length>0){
					$.each(data, function(index, sch){
						str += "<div class='input-group mb-3'>"
							+"<input type='text' class='form-control' aria-describedby='selectBtn" + cnt + "' value='" + sch.scName + " " + sch.scCampus + " " + sch.scMajor + "' readonly>"
							+"<input type='hidden' class='form-control' id='selScNo' value='" + sch.scNo + "' readonly>"
							+"<input type='hidden' class='form-control' id='selScName' value='" + sch.scName + "' readonly>"
							+"<input type='hidden' class='form-control' id='selScCampus' value='" + sch.scCampus + "' readonly>"
							+"<input type='hidden' class='form-control' id='selScMajor' value='" + sch.scMajor + "' readonly>"
							+"<input type='hidden' class='form-control' id='selScChecknum' value='" + sch.scChecknum + "' readonly>"
							+"<button class='btn btn-outline-secondary' type='button' id='selectBtn"+ cnt +"'>"
							+"<i class='fas fa-check'>"
							+"</i>"
							+"</button>"
							+"</div>";
						cnt++;
					});
					$("#getResult").append(str);
				}else{
					str += "<div class='input-group mb-3'>"
						+"<input type='text' class='form-control' value='검색 결과가 없습니다.' disabled readonly>"
						+"</div>";
					$("#getResult").append(str);
				}
			},
			error: function(){
				
			}
		});
	});
	
	$("#getResult").on("click", "button", function(){
		var str ="";
		$(this).attr("class", "btn btn-outline-success")
		var check = $(this).closest("div").clone();
		$("#schCheckNum").empty();
		$("#getResult").empty();
		$("#getResult").append(check);
		str += "<label>기관 인증번호</label>"
			+ "<input type='text' id='checkNum' class='form-control'>";
		$("#schCheckNum").append(str);
		$("#schoolSelBtn").show();
	});
	
	var count = 1;
	var schCheckCnt=0;
	
	$("#schoolSelBtn").on("click", function(e){//선택버튼 클릭
		var scChecknum = $("#checkNum").val();
		var scNo = $("#selScNo").val();
		var scName = $("#selScName").val();
		var scCampus = $("#selScCampus").val();
		var scMajor = $("#selScMajor").val();
		
		if(schCheckCnt<1){
			
			var str = "<div class='input-group mb-3 mySchool'>"
				+"<input type='text' class='form-control' aria-describedby='selectBtn'"+count+" value='"+scName+" "+scCampus+"캠퍼스 "+scMajor+"' readonly disabled>"
				+"<button class='btn btn-outline-secondary delSchool' type='button'>"
				+"<i class='fas fa-minus'>"
				+"</i>"
				+"</button>"
				+"<input type='hidden' class='form-control' name='scNo' value='"+scNo+"'>"
				+"</div>";
			
			//기관 인증번호 확인
 			if($("#selScChecknum").val() != scChecknum){//기관 인증번호가 일치하지 않을 때
 				$("#checkNum").css({"border" : "solid 2px",
 									"border-color": "red"});
 				setTimeout(function() { 
					$("#checkNum").css({"border-color": ""});	
					}, 1000);
 				
			}else{
				$("#schoolModal").modal('hide');
				
				schCheckCnt++;
				
				$("#schCheckCnt").val(schCheckCnt);
				
				count++;
				
				$("#selSchool").append(str);
			}


		}else{
			$("#getResult").empty();
			$("#schCheckNum").empty();
			

			str = "<div class='input-group mb-3'>"
				+"<input type='text' class='form-control' value='소속 기관은 하나만 선택 가능합니다.' disabled readonly>"
				+"</div>";
				
			$("#getResult").append(str);
		}

	});
	
	$("#selSchool").on("click", "button", function(){
		$(this).closest("div").remove();
		schCheckCnt--;
		$("#schCheckCnt").val(schCheckCnt);
	});


</script>
	<%@ include file="../include/footer.jsp"%>

