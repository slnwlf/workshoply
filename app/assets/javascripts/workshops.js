$(function() {
	// set previous used filters
	urlParams = getJsonFromUrl();
	$("body select#location").val(urlParams.location.toLowerCase());
	$("body select#topic").val(urlParams.topic.toLowerCase());
});