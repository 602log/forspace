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
	
	.img_wrap{
		text-align : center;
		margin : 20px;
	}
	#imgProfile{
		border-radius: 50%;
		width : 200px;
	}
</style>
<%@ include file="../include/header.jsp"%>
        
        <div class="container mt-5 main-content">
        <form class="form-material" method="post" id="joinFrm" action="/member/adminjoin" enctype="multipart/form-data">
			<div class="row">
				
				    <div class="col-lg-6"> 
						<label>프로필</label>
						<div class="img_wrap">
							<img id="imgProfile" src="../resources/images/user.png" alt="profile">
						</div>
						<div class="form-group form-default">
							<input type="file" class="form-control form-control-user inputImg" name="image">
						</div>	
	                </div>
	                <div class="col-lg-6">
						<label>소속 기관</label>
						<div class="form-group form-default">
							<input type="text" name="scName" id="scName" class="form-control" placeholder="OO대학교">
						</div>
						<div class="form-group form-default">
							<input type="text" name="scCampus" id="scCampus" class="form-control" placeholder="OO캠퍼스">
						</div>
						<div class="form-group form-default">
							<input type="text" name="scMajor" id="scMajor" class="form-control" placeholder="학과명">
						</div>
						<div class="form-group form-default">
							<button type="button" value="N" id="schoolCheckBtn" name="schoolCheckBtn" class="btn btn-primary" style="border-radius: 30px;" onclick="schoolCheck()">기관명 중복확인</button>
						</div>
						
						
						
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
						
						<label>사번</label>
						<div class="form-group form-default">
							<input type="text" name="meNo" id="meNo" class="form-control">
						</div>
						<input type="hidden" name="meRole" id="meRole" value="ADMIN">
                	</div> 
			</div>
				
				<div class="mt-5" align="center">
					<input type="submit" id="submit" name="submit" class="btn btn-primary" value="가입">
					<input type=button id="cancel" name="cancel" class="btn btn-danger" value="취소"><!-- 홈화면으로 돌아가기 (학생, 교직원 선택하는 화면)-->
				</div>
			
       </form> 
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

var sel_file;

	$(document).ready(function(){
		$("#cancel").on("click", function(){
			location.href="/member/login";
		});
		
	$(".inputImg").on("change", handleImgFileSelect);
		
		function handleImgFileSelect(e){
			var files = e.target.files;
			var filesArr = Array.prototype.slice.call(files);
			var str = "";
			
			filesArr.forEach(function(f){
				if(!f.type.match("image.*")){
					
					$(".modal").modal();
					$(".modal-body").empty();
					str += "<p>이미지 파일만 업로드해주세요.</p>";
					$(".modal-body").append(str);
					//alert("이미지 파일만 업로드해주세요.");
					$(".inputImg").val("");
					return;
				}
				sel_file = f;
				
				var reader = new FileReader();
				reader.onload = function(e){
					$("#imgProfile").attr("src", e.target.result);
				}
				reader.readAsDataURL(f);
			});
		}
		
		$("#submit").on("click", function(){
		
			var mePwd = $("#mePwd").val();
			var mePwdCheck = $("#mePwdCheck").val();
			var str="";
			
				if($("#scName").val() == ""){
					$(".modal").modal();
					$(".modal-body").empty();
					str += "<p>학교명을 입력해주세요.</p>";
					$(".modal-body").append(str);
					//alert("학교명을 입력해주세요.");
					$("#scName").focus();
					return false;
				}
				if($("#scCampus").val() == ""){
					$(".modal").modal();
					$(".modal-body").empty();
					str += "<p>캠퍼스명을 입력해주세요.</p>";
					$(".modal-body").append(str);
					//alert("캠퍼스명을 입력해주세요.");
					$("#scCampus").focus();
					return false;
				}
				if($("#scMajor").val() == ""){
					$(".modal").modal();
					$(".modal-body").empty();
					str += "<p>학과명을 입력해주세요.</p>";
					$(".modal-body").append(str);
					//alert("학과명을 입력해주세요.");
					$("#scMajor").focus();
					return false;
				}
			
				if($("#meEmail").val() == ""){
					$(".modal").modal();
					$(".modal-body").empty();
					str += "<p>이메일을 입력해주세요.</p>";
					$(".modal-body").append(str);
					//alert("이메일을 입력해주세요.");
					$("#meEmail").focus();
					return false;
				}
				
				
				if($("#mePwd").val() == "" || mePwd.length<8 || mePwd.length>15){
					$(".modal").modal();
					$(".modal-body").empty();
					str += "<p>비밀번호는 8~15자 사이로 입력해주시기 바랍니다.</p>";
					$(".modal-body").append(str);
					//alert("비밀번호는 8~15자 사이로 입력해주시기 바랍니다.");
					$("#mePwd").focus();
					return false;
				}
				
				if($("#mePwdCheck").val() == "" || mePwd != mePwdCheck){
					$(".modal").modal();
					$(".modal-body").empty();
					str += "<p>비밀번호가 일치하지 않습니다.</p>";
					$(".modal-body").append(str);
					//alert("비밀번호가 일치하지 않습니다.");
					$("#mePwdCheck").focus();
					return false;
				}
				
				if($("#meName").val() == ""){
					$(".modal").modal();
					$(".modal-body").empty();
					str += "<p>이름을 입력해주시기 바랍니다.</p>";
					$(".modal-body").append(str);
					//alert("이름을 입력해주시기 바랍니다.");
					$("#meName").focus();
					return false;
				}
				
				if($("#meNo").val() == ""){
					$(".modal").modal();
					$(".modal-body").empty();
					str += "<p>사번을 입력해주시기 바랍니다.</p>";
					$(".modal-body").append(str);
					//alert("사번을 입력해주시기 바랍니다.");
					$("#meNo").focus();
					return false;
				}
				
				var schoolCheckVal = $("#schoolCheckBtn").val();
				var emailCheckVal = $("#emailCheckBtn").val();
				
				if(schoolCheckVal == "N"){
					$(".modal").modal();
					$(".modal-body").empty();
					str += "<p>기관명 중복확인버튼을 눌러주세요.</p>";
					$(".modal-body").append(str);
					//alert("기관명 중복확인버튼을 눌러주세요.");
					return false;
				}else if(schoolCheckVal == "Y"){
					if(emailCheckVal == "N" ){
						$(".modal").modal();
						$(".modal-body").empty();
						str += "<p>중복확인버튼을 눌러주세요.</p>";
						$(".modal-body").append(str);
						//alert("중복확인버튼을 눌러주세요.");
						return false;
					}else if(emailCheckVal == "Y"){
						$("#joinFrm").submit();
					}
				}
				
				
					

		});
	});

	function ECheck(email){
		var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		return (email != '' && email != 'undefined' && regex.test(email));
	}//ECheck() end
	

	function schoolCheck(){
		
		var scName = $("#scName").val();
		var scCampus = $("#scCampus").val();
		var scMajor = $("#scMajor").val();
		var str="";
		
		if(scName == "" || scCampus == "" || scMajor == ""){
			$(".modal").modal();
			$(".modal-body").empty();
			str += "<p>정확한 기관명을 작성해주세요.</p>";
			$(".modal-body").append(str);
			//alert("정확한 기관명을 작성해주세요.");
			return false;
		}
		
		$.ajax({
			url : "/member/schoolCheck",
			type : "post",
			data : {scName : scName,
					scCampus : scCampus,
					scMajor : scMajor},
			success : function(data){
				if(data == "success"){
					$("#schoolCheckBtn").attr("value", "Y");
					
					$(".modal").modal();
					$(".modal-body").empty();
					str += "<p>등록 가능한 기관입니다.</p>";
					$(".modal-body").append(str);
					//alert("등록 가능한 기관입니다.");
				}else{
					$(".modal").modal();
					$(".modal-body").empty();
					str += "<p>이미 등록된 기관입니다.</p>";
					$(".modal-body").append(str);
					//alert("이미 등록된 기관입니다.");
					return false;
				}
			}
		});
	}
	
	function emailCheck(){
		var str = "";
	
		if(! (ECheck($("#meEmail").val()))){
			$(".modal").modal();
			$(".modal-body").empty();
			str += "<p>올바른 이메일을 입력해주세요.</p>";
			$(".modal-body").append(str);
			//alert("올바른 이메일을 입력해주세요.");
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
					
					$(".modal").modal();
					$(".modal-body").empty();
					str += "<p>사용 가능한 아이디 입니다.</p>";
					$(".modal-body").append(str);
					//alert("사용 가능한 아이디 입니다.");
				}else{
					$(".modal").modal();
					$(".modal-body").empty();
					str += "<p>중복된 아이디 입니다.</p>";
					$(".modal-body").append(str);
					//alert("중복된 아이디 입니다.");
					return false;
				}
			}
		});
	}

</script>
	<%@ include file="../include/footer.jsp"%>

