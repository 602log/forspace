<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.buttons{
	width : 300px;
}
</style>
<%@ include file="../include/header.jsp"%>
    <!-- Page content-->
	<div class="container" style="max-width: 900px; margin-top: 30px; margin-bottom: 30px">
		<div class="row">
			<div class="col-12 mb-4">
		        <div class="card shadow h-100 py-2">
			        <div class="card-body py-2">
				        <div class="row no-gutters align-items-center">
					        <div class="col">
						        <div class="text-sm font-weight-bold text-primary text-uppercase mb-1">제목</div>
						        <div class="h5 mb-0 font-weight-bold">${dto.noSubject}</div>
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
					            <div class="h5 mb-0">
					            	${dto.noContent}
					            </div>
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
					<input type="button" class="btn btn-primary buttons" id="modify" onclick="return modify(${dto.noNo})" value="수정하기">
				</div>
			</c:if>
				<div class="mt-1">
					<input type="button" class="btn btn-secondary buttons" id="forList" onclick="location.href='/notice/noticeList'" value="목록보기">
				</div>
			</sec:authorize>
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
<script>

$(document).ready(function(){
	var msg = '${msg}';
	if (!(msg===''||history.state)){
		var modal= $(".modal");
		modal.modal();
	}
});

function modify(noNo){
	//console.log(noNo);
	location.href="/notice/modifyNotice?noNo="+noNo;
}
</script>
	<%@ include file="../include/footer.jsp"%>

