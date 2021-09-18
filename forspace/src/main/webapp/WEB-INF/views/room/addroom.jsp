<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	.limitTime{
		float:left;
	}
</style>
<%@ include file="../include/header.jsp"%>
        <!-- Page content-->
        <div class="container mt-5">
        	<div class="row">
                <div class="col-lg-4"> 
					<label>건물층</label>
					<div class="form-group form-default">
						<input type="number" name="roFloor" id="roFloor" class="form-control">
					</div>
					<label>연습실 개수</label>
					<div class="form-group form-default">
						<input type="number" name="roFloor" id="roFloor" class="form-control" min="1">
					</div>
					<label>최대 수용인원</label>
					<div class="form-group form-default">
						<input type="number" name="roFloor" id="roFloor" class="form-control" min="1">
					</div>
					<label>이용가능시간</label>
					<div class="form-group form-default">
						<table style="width:100%;">
							<tr>
								<td><input type="time" name="roFloor" id="roFloor" class="form-control"></td>
								<td>~</td>
								<td><input type="time" name="roFloor" id="roFloor" class="form-control"></td>
							</tr>
						</table>
						
					</div>
                </div>
                
                <div class="col-lg-4">
					<label>옵션 <i role="button" class="fas fa-plus-circle modalBtn" style="color:purple;"></i></label>
                </div>
				
				
				<%@ include file="../include/side.jsp"%>
			</div>
			
			<!-- modal -->
			<div class="modal" id="itemModal" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
							<h4 class="modal-title">옵션 추가</h4>
						</div>
						<div class="modal-body">
							<label>옵션</label>
							<div class="input-group mb-3">
								<input type="text" class="form-control searchInput" aria-describedby="btnAddon">
								<button calss="btn btn-outline-secondary itemSearch" type="button" id="btnAddon"><i class="fa fa-search"></i></button>
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
				
        </div>
	<%@ include file="../include/footer.jsp"%>
</body>
</html>
