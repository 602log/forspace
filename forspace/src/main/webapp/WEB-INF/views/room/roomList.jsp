<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://code.iconify.design/2/2.0.3/iconify.min.js"></script>



<style>
	.floorCnt{
		display:flex;
		justify-content: center;
  		align-items: center;
	}

	.likeBtn .heart-shape{
		display : inline;
		color : red;
	}
	
	.post-slider{
		width : 100%;
		margin : 0px auto;
		position : relative;
		text-align : center;
	}
	
	.post-slider .next{
		position : absolute;
		top : 15%;
		right : 30px;
		font-size : 2em;
		color : gray;
		cursor : pointer;
	}
	
	.post-slider .prev{
		position : absolute;
		top : 15%;
		left : 30px;
		font-size : 2em;
		color : gray;
		cursor : pointer;
	}
	
	.post-slider .post-wrapper{
		width : 84%;
		height : 80px;
		margin : 0px auto;
		overflow : hidden;
		padding : 10px 0px 10px 0px;
	}
	
	.post-slider .post-wrapper .post{
		width : 100px;
		height : 100px;
		margin : 0px 10px;
		display : inline-block;
		background : white;
		border-radius : 5px;
	}
	
	.card-body, .post{
		cursor: pointer;
	}
	
	i{
		cursor: pointer;
	}
	#roomBtn{
		border: none;
		border-radius: 50px; 
		background-color: purple;
		text-align : center;
	}

</style>
<%@ include file="../include/header.jsp"%>

        <!-- Page content-->
        <div class="container mt-5 main-content">

        	<div class="row">
        		<div class="col-lg-12">
        		<!--층 수 시작-------------------------------------------------------------------------------------------------------------->
      				<div class="post-slider">
      					<i class="fas fa-chevron-left prev"></i>
      					<i class="fas fa-chevron-right next"></i>
      					<div class="post-wrapper">
						<c:forEach var="roFloor" items="${floorList}">
							<div class="post" onClick="location.href='/room/roomList?roFloor=${roFloor}'">
								<a><h2><c:out value="${roFloor }"/>F</h2></a>
							</div>
						</c:forEach>
						</div>
        			</div>
        		<!--층 수 끝--------------------------------------------------------------------------------------------------------------->
  	           
  	            <!-- 층별 연습실------------------------------------------------------------------------------------------------------------>
  	            	
  	                <c:choose>
  	                	<c:when test="${empty list}">
  	                		<p class="text-center" style="color:red; font-size:20px;">등록된 연습실이 없습니다.</p>
  	                	</c:when>
  	                	<c:otherwise>
  	                	  	<div class="card-columns">
								<c:forEach var="list" items="${list }">
									<div class="card" style="border-radius:50px;">
										<div class="card-body text-center" onClick="location.href='/room/roomDetail?roNo=${list.roNo}'">
											<i onClick="location.href='/room/roomDetail?roNo=${list.roNo}'"><h5><c:out value="${list.roName }"/></h5></i>
											<c:choose>
												<c:when test="${list.myLike == 0}">
													<a class="btn likeBtn" data-rono="${list.roNo }">
														<span class="heart-shape">♡</span>
													</a>
												</c:when>
												<c:otherwise>
													<a class="btn likeBtn" data-rono="${list.roNo }">
														<span class="heart-shape">♥</span>
													</a>
												</c:otherwise>
											</c:choose>
											<span class="like-count">${list.roLikecnt }</span>
										</div>
									</div>
								</c:forEach>
							</div>
  	                	</c:otherwise>
					</c:choose>
				<!-- 층별 연습실------------------------------------------------------------------------------------------------------------>
	             </div>
			</div>

        </div>

        <!-- modal -->
        <div class="modal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Result</h5>
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
$(document).on("click", ".likeBtn", function(e){
	var roNo = $(this).data("rono");
	var meEmail = '${loginUser}';
	
	//alert(roNo + meEmail);

	$.ajax({
		type : "POST",
		url : "/room/insertLike",
		data : {roNo : roNo,
				meEmail : meEmail},
		dataType : "text",
		success : function(data){
			if(data == "like"){
				$(".heart-shape").text("♥");
				
			}else{
				$(".heart-shape").text("♡");
				
			}
			location.reload();
		}
	});

});

$(".post-wrapper").slick({
	slidesToShow : 4,
	slidesToScroll : 1,
	autoplay : false,
	nextArrow : $(".next"),
	prevArrow : $(".prev")
});

$(document).ready(function() {
	var msg = '${msg}';
	console.log("msg>>", msg);
	if (!(msg === '' || history.state)) {
		var modal = $(".modal");
		console.log(modal);
		modal.modal();
	}
});
</script>
	<%@ include file="../include/footer.jsp"%>

