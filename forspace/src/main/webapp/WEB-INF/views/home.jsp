<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>

</style>
<%@ include file="include/header.jsp"%>
        <!-- Page content-->
        <h2 class="mb-4">forspace home</h2>
        <p>Welcome forspace</p>
        
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
	<%@ include file="include/footer.jsp"%>

