$(function() {
	// set previous used filters in workshops index
	if (typeof useJsonFromUrl !== "undefined" && useJsonFromUrl && location.search) {
		urlParams = getJsonFromUrl();
		if (urlParams.location) $("body select#location").val(urlParams.location.toLowerCase());
		if (urlParams.topic) $("body select#topic").val(urlParams.topic.toLowerCase());
	}
});