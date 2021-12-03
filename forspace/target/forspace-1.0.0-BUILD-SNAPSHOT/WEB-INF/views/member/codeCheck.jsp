<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
#modifyBtn{
	border: none; 
	border-radius: 50px; 
	background-color: purple;
}
#scChecknum{
	text-align : center;
	font-size : 20px;
}
</style>
<%@ include file="../include/header.jsp"%>
        <!-- Page content-->
        <div class="container main-container">
        	<div class="row justify-content-center" style="display: flex; align-items: center; min-height: 500px;">
               <div class="col-xl-5 col-lg-5 col-md-5"> 
					<p style="font-size:25px;">인증번호</p>
					<form action="../member/modifyCode" method="post">
						<div class="form-group">
							<input type="text" id="scChecknum" name="scChecknum" class="form-control form-control-user" value="${dto.scChecknum }" readonly/>
							<input type="hidden" id="scNo" name="scNo" value="${dto.scNo }"/>
						</div>
						<button type="submit" class="btn btn-primary btn-lg btn-block btn-user" id="modifyBtn">변경</button>
					</form>
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
<script>
$(document).ready(function(){
	var msg = '${msg}';
	if (!(msg===''||history.state)){
		var modal= $(".modal");
		modal.modal();
	}
});
</script>
	<%@ include file="../include/footer.jsp"%>

