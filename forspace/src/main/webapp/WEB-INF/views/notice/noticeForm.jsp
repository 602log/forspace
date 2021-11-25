<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.buttons{
	width : 300px;
}
</style>
<%@ include file="../include/header.jsp"%>
    <!-- Page content-->
    <form action="../notice/insertNotice" method="post" id="insertFrm">
	<div class="container" style="max-width: 900px; margin-top: 30px; margin-bottom: 30px">
		<div class="row">
			<div class="col-12 mb-4">
		        <div class="card shadow h-100 py-2">
			        <div class="card-body py-2">
				        <div class="row no-gutters align-items-center">
					        <div class="col">
						        <div class="text-sm font-weight-bold text-primary text-uppercase mb-1">제목</div>
						        <div class="h5 mb-0 font-weight-bold">
						        	<input type="text" class="form-control" id="noSubject" name="noSubject">
						        </div>
					        </div>
				        </div>
			        </div>
		        </div>
	        </div>
	        
	        <div class="col-12 mb-4">
	            <div class="card shadow h-100 py-2">
		            <div class="card-body pt-2" style="min-height: 300px">
			            <div class="row no-gutters align-items-center">
				            <div class="col">
					            <div class="text-sm font-weight-bold text-primary text-uppercase mb-1">상세 내용</div>
					            <textarea class="form-control" rows="15" id="noContent" name="noContent" placeholder="15글자 이상 입력해주세요."></textarea>
				            </div>
			            </div>
		            </div>
	            </div>
           	</div>
		</div>
		
		<div align="center" class="rows" id="btns">
				<div class="col-6 mt-1">
					<input type="button" class="btn btn-primary buttons" id="modify" onclick="return insertFrm()" value="등록하기">
				</div>
				<div class="mt-1">
					<input type="button" class="btn btn-secondary buttons" id="forList" onclick="location.href='../notice/noticeList'" value="목록보기">
				</div>
		</div>
	</div>
	</form>
<script>
	
	function insertFrm(){
		
		var content = $("#noContent").val();
		
		if($("#noSubject").val() == ""){
			alert("제목을 작성해주세요.");
			$("#noSubject").focus();
			return false;
		}
		
		if(content.length < 15){
			alert("내용을 15글자 이상 작성해주세요.");
			$("#noContent").focus();
			return false;
		}
		
		$("#insertFrm").submit();
	}

</script>
	<%@ include file="../include/footer.jsp"%>