<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
.buttons{
	width : 300px;
}
</style>
<%@ include file="../include/header.jsp"%>
    <!-- Page content-->
	<div class="container">
		<div class="col-12 mb-4">
			<input type="text" class="form-control form-control" id="noSubject" value="${dto.noSubject }" readonly>
         </div>
         <div class="col-12 mb-4">
			<textarea class="form-control" rows="15" id="noContent" name="text" readonly>${dto.noContent }</textarea>
         </div>
		
		<div align="center" class="rows" id="btns">
			<sec:authorize access="isAuthenticated()">
			<c:if test="${loginUser eq dto.meEmail || loginUserRole eq 'ADMIN' }">
				<div class="col-6 mt-1">
					<input type="button" class="btn btn-primary buttons" id="modify" value="수정하기">
				</div>
				<div class="col-6 mt-1">
					<input type="button" class="btn btn-danger buttons" id="delete" value="삭제하기" >
				</div>
			</c:if>
				<div class="mt-1">
					<input type="button" class="btn btn-secondary buttons" id="forList" value="목록보기">
				</div>
			</sec:authorize>
		</div>
	</div>
<script>

</script>
	<%@ include file="../include/footer.jsp"%>

