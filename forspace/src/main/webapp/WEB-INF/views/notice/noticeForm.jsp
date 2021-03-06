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
	
	function insertFrm(){
		
		var content = $("#noContent").val();
		var str="";
		
		if($("#noSubject").val() == ""){
			$("#msgModal").modal();
			$("#msgBody").empty();
			str += "<p>제목을 작성해주세요.</p>";
			$("#msgBody").append(str);
			//alert("제목을 작성해주세요.");
			$("#noSubject").focus();
			return false;
		}
		
		if(content.length < 15){
			$("#msgModal").modal();
			$("#msgBody").empty();
			str += "<p>내용을 15글자 이상 작성해주세요.</p>";
			$("#msgBody").append(str);
			//alert("내용을 15글자 이상 작성해주세요.");
			$("#noContent").focus();
			return false;
		}
		
		$("#insertFrm").submit();
	}

</script>
	<%@ include file="../include/footer.jsp"%>