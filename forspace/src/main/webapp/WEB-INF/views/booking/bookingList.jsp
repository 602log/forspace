<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- fullcalendar CDN -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
<style>

</style>
<%@ include file="../include/header.jsp"%>
        <!-- Page content-->
       	<div class="container main-container">
		       	<div class="col-12 mb-3">
		       		<h2>예약확인</h2>
					<div class="card shadow mb-3">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">예약현황</h6>
						</div>
						<div class="card-body">
						<div id="calendar"></div>
						</div>
					</div>
				</div>
       	</div>


<script>

var calendarEl = document.getElementById('calendar');
var calendar = new FullCalendar.Calendar(calendarEl, {
  themeSystem: 'bootstrap',
  initialView: 'dayGridMonth',
  locale: 'ko',
  contentHeight: "auto",
  events: [
	  $.ajax({
		  type : "post",
		  url : "/booking/getMyBooking",
		  data : {meEmail : "${loginUser}"},
		  success : function(list){
			  for(var i=0; i<list.length; i++){
				  console.log(list[i].roName);
				  console.log(list[i].boDateStr);
				  console.log(list[i].boTime);
				  calendar.addEvent({
					  title : list[i].boTime+" "+list[i].roName+'호',
					  start : list[i].boDateStr
				  })
			  }
		  }
	  })
  ]

});
calendar.render();
</script>
	<%@ include file="../include/footer.jsp"%>

