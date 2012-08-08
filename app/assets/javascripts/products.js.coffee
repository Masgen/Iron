# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	$("#will-paginate-container").on "click", "a.next_page", (event) ->
		event.preventDefault()
		url = $("a.next_page").attr("href")
		if url
			$('#will-paginate-container').text('Fetching more products...')
			$.getScript(url)
	$("form.fill-fields input[type='submit']").click ->
		if !$(".mini-loader").length
			$(this).after("<span class='mini-loader'><img src='/assets/products/form_loader.gif' /></span>")
			$("#product_title").after("<span class='mini-loader'><img src='/assets/products/form_loader.gif' /></span>")
			$("#product_imdb_score").after("<span class='mini-loader'><img src='/assets/products/form_loader.gif' /></span>")
			$("#product_year_1i").after("<span class='mini-loader'><img src='/assets/products/form_loader.gif' /></span>")
			$("#product_director").after("<span class='mini-loader'><img src='/assets/products/form_loader.gif' /></span>")
			$("#product_actors").after("<span class='mini-loader'><img src='/assets/products/form_loader.gif' /></span>")
			$("#product_remote_poster_url").after("<span class='mini-loader'><img src='/assets/products/form_loader.gif' /></span>")
			$("#product_trailer_url").after("<span class='mini-loader'><img src='/assets/products/form_loader.gif' /></span>")
			$("#product_duration").after("<span class='mini-loader'><img src='/assets/products/form_loader.gif' /></span>")
			$("#product_summary").after("<span class='mini-loader'><img src='/assets/products/form_loader.gif' /></span>")
