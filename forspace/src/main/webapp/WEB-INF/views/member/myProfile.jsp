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
	#imgPro{
		border-radius: 50%;
		width : 250px;
		height : 250px;
	}
</style>
<%@ include file="../include/header.jsp"%>
        
        <div class="container mt-5 main-content">
        <form class="form-material" method="post" id="updateFrm" action="/member/updateProfile" enctype="multipart/form-data">
			<div class="row">
				
				    <div class="col-lg-6"> 
						<label>프로필</label>
						<div class="img_wrap">
						<c:choose>
							<c:when test="${not empty img && img.imName != '' }">
								<img id="imgPro" src="/image/show?imagePath=${img.imagePath }" alt="profile">
							</c:when>
							<c:otherwise>
								<img id="imgPro" src="../resources/images/user.png" alt="profile">
							</c:otherwise>
						</c:choose>
						</div>
						<div class="form-group form-default">
							<input type="file" class="form-control form-control-user inputImg" name="image">
						</div>	
	                </div>
	                <div class="col-lg-6">
						
						<label>이메일</label>
						<div class="form-group form-default" id="emailBlock">
							<div id="firstDIV">
								<input type="text" name="meEmail" id="meEmail" class="form-control" value="${dto.meEmail }" readonly>
							</div>
						</div>
						
						<label>새 비밀번호</label>
						<div class="form-group form-default">
							<input type="password" name="mePwd" id="mePwd" class="form-control" placeholder="비밀번호를 변경을 원하시면 입력하세요.">
						</div>
						
						<label>비밀번호 확인</label>
						<div class="form-group form-default">
							<input type="password" name="mePwdCheck" id="mePwdCheck" class="form-control">
						</div>
						
						<label>이름</label>
						<div class="form-group form-default">
							<input type="text" name="meName" id="meName" class="form-control" value="${dto.meName }">
						</div>
						
						<label>학번</label>
						<div class="form-group form-default">
							<input type="text" name="meNo" id="meNo" class="form-control" value="${dto.meNo }">
						</div>
						<input type="hidden" name="meRole" id="meRole" value="USER">
                	</div>
                
			</div>
				
				<div class="mt-5" align="center">
					<input type="submit" id="submit" name="submit" class="btn btn-primary" value="수정">
					<input type=button id="cancel" name="cancel" class="btn btn-danger" value="취소"><!-- 홈화면으로 돌아가기 (학생, 교직원 선택하는 화면)-->
				</div>
			
       </form> 
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
			location.href="/";
		});
		
		$(".inputImg").on("change", handleImgFileSelect);
		
		function handleImgFileSelect(e){
			var files = e.target.files;
			var filesArr = Array.prototype.slice.call(files);
			var str="";
			
			filesArr.forEach(function(f){
				if(!f.type.match("image.*")){
					$("#msgModal").modal();
					$("#msgBody").empty();
					str += "<p>이미지 파일만 업로드해주세요.</p>";
					$("#msgBody").append(str);
					//alert("이미지 파일만 업로드해주세요.");
					$(".inputImg").val("");
					return;
				}
				sel_file = f;
				
				var reader = new FileReader();
				reader.onload = function(e){
					$("#imgPro").attr("src", e.target.result);
				}
				reader.readAsDataURL(f);
			});
		}
		
		$("#submit").on("click", function(){
			
			var str="";
			
				if ($("#mePwd").val() != "") {
					if ($("#mePwd").val() != $("#mePwdCheck").val()) {
						
						$("#msgModal").modal();
						$("#msgBody").empty();
						str += "<p>비밀번호가 일치하지 않습니다.</p>";
						$("#msgBody").append(str);
						
						//alert("비밀번호가 일치하지 않습니다.");
						$("#mePwdCheck").focus();
						return false;
					}
				}
				
				if($("#meNo").val() == ""){
					
					$("#msgModal").modal();
					$("#msgBody").empty();
					str += "<p>학번을 입력해주시기 바랍니다.</p>";
					$("#msgBody").append(str);
					
					//alert("학번을 입력해주시기 바랍니다.");
					$("#meNo").focus();
					return false;
				}
			
		});
	});

</script>
	<%@ include file="../include/footer.jsp"%>

