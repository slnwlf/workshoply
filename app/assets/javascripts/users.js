$(function() {
	$("#user_avatar").hide();
	$("input#user_avatar").on("change", function() {
		$("form.edit_user").submit();
	});
});