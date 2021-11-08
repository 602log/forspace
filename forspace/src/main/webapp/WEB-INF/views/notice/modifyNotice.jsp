<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.buttons{
	width : 300px;
}
</style>
<%@ include file="../include/header.jsp"%>
    <!-- Page content-->
    <form action="/notice/modify" method="post" id="modifyFrm" onkeydown="return event.key != 'Enter';">
	<div class="container" style="max-width: 900px; margin-top: 30px; margin-bottom: 30px">
		<div class="row">
			<div class="col-12 mb-4">
		        <div class="card shadow h-100 py-2">
			        <div class="card-body py-2">
				        <div class="row no-gutters align-items-center">
					        <div class="col">
						        <div class="text-sm font-weight-bold text-primary text-uppercase mb-1">제목</div>
						        <div class="h5 mb-0 font-weight-bold">
						        	<input type="text" class="form-control" id="noSubject" name="noSubject" value="${dto.noSubject}">
						        	<input type="hidden" id="noNo" name="noNo" value="${dto.noNo }">
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
					            <textarea class="form-control" rows="15" id="noContent" name="noContent" placeholder="15글자 이상">${dto.noContent}</textarea>
				            </div>
			            </div>
		            </div>
	            </div>
           	</div>
		</div>
		
		<div align="center" class="rows" id="btns">
			<sec:authorize access="isAuthenticated()">
			<c:if test="${loginUser eq dto.meEmail || loginUserRole eq 'ADMIN' }">
				<div class="col-6 mt-1">
					<input type="button" class="btn btn-primary buttons" id="modify" onclick="return modifyFrm()" value="수정하기">
				</div>
				<div class="col-6 mt-1">
					<input type="button" class="btn btn-danger buttons" id="delete" onclick="return false;" value="삭제하기" >
				</div>
			</c:if>
				<div class="mt-1">
					<input type="button" class="btn btn-secondary buttons" id="forList" onclick="location.href='/notice/noticeList'" value="목록보기">
				</div>
			</sec:authorize>
		</div>
	</div>
	</form>
<script>
	
	function modifyFrm(){
		
		if($("#noSubject").val() == ""){
			alert("제목을 작성해주세요.");
			$("#noSubject").focus();
			return false;
		}
		if($("#noContent").val() == ""){
			alert("내용을 작성해주세요.");
			$("#noContent").focus();
			return false;
		}
		
		$("#modifyFrm").submit();
	}
	
	$("#delete").on("click", function(e){
		console.log("삭제클릭");
		e.preventDefault();
		if(confirm("삭제하시겠습니까?")){
			$("#modifyFrm").attr("action", "/notice/remove");
			$("#modifyFrm").submit();
		}
	});

</script>
	<%@ include file="../include/footer.jsp"%>

