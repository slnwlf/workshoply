$(function() {
	$("#user_avatar").hide();
	$("input#user_avatar").on("change", function() {
		var fileName = $(this).val().match(/[^\\]+$/)[0];
		if (fileName.length > 20) {
			fileName = fileName.match(/(^.{10})|(\w{3,4}$)/g).join("...");
		}
		$("label[for='user_avatar']").text(fileName);
	});
	$("input.missing").on('keyup', function(e) {
		if ($(this).val().length > 0) {
			$(this).removeClass("missing");
		}
	});
});