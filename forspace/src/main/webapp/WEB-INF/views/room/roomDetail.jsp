<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>

</style>
<%@ include file="../include/header.jsp"%>
        <!-- Page content-->
        <div class="container mt-5 main-content">
        	<div class="row">
                <div class="col-lg-4">
                	<div class="card shadow h-20 py-2 mb-4">
	                	<div class="card-body py-2">
	                		<div class="row no-gutters align-items-center">
	                			<div class="col">
	                				<div class="text-sm font-weight-bold text-primary text-uppercase mb-1">건물층</div>
	                				<div class="h5 mb-0">${dto.roFloor }</div>
	                			</div>
	                		</div>
	                	</div>
                	</div>
                 
                 
               
	                <div class="card shadow h-20 py-2 mb-4">
		                <div class="card-body py-2">
		                	<div class="row no-gutters align-items-center">
		                		<div class="col">
		                			<div class="text-sm font-weight-bold text-primary text-uppercase mb-1">최대수용인원</div>
		                			<div class="h5 mb-0">${dto.roMax } 명까지</div>
		                		</div>
		                	</div>
		                </div>
	                </div>
                

				
					<div class="card shadow h-20 py-2 mb-4">
		                <div class="card-body py-2">
		                	<div class="row no-gutters align-items-center">
		                		<div class="col">
		                			<div class="text-sm font-weight-bold text-primary text-uppercase mb-1">이용가능시간</div>
		                			<div class="h5 mb-0">${dto.roStart } ~ ${dto.roClose }</div>
		                		</div>
		                	</div>
		                </div>
                	</div> 
                	
                	<div class="card shadow h-20 py-2 mb-4">
		                <div class="card-body py-2">
		                	<div class="row no-gutters align-items-center">
		                		<div class="col">
		                			<div class="text-sm font-weight-bold text-primary text-uppercase mb-1">기본예약시간</div>
		                			<div class="h5 mb-0">예약시 ${dto.roLimit } 시간 이용가능</div>
		                		</div>
		                	</div>
		                </div>
                	</div> 
                            	
				</div>	
			</div>	
        </div>
<script>

</script>
	<%@ include file="../include/footer.jsp"%>

