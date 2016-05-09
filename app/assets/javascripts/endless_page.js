$(document).ready(function() {
	if ($('.pagination').length) {
		$(window).scroll(function() {
			var url = $('.pagination .next_page').attr('href');
			if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
				$('.pagination').show().text("Please Wait...");
				return $.getScript(url);
			} else {
				$('.pagination').hide();
			}
		});
	return $(window).scroll();
	}
});