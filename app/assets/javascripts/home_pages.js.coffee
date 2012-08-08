# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	if $(".right").first().parent().find(".slide").length <= 7
		$(".right").first().css("display","none")
	if $(".right").last().parent().find(".slide").length <= 7
		$(".right").last().css("display","none")
	$(".right").click ->
		$(@).parent().find(".limit").animate({"marginLeft":"-=115px"})
		counter = parseInt($(@).parent().find(".limit").attr("counter")) + 1
		$(@).parent().find(".limit").attr("counter", String(counter))
		if counter == ($(@).parent().find(".slide").length - 7)
			$(@).hide()
		if counter != 0
			$(@).parent().find(".left").show()
	$(".left").click ->
		$(@).parent().find(".limit").animate({"marginLeft":"+=115px"})
		counter = parseInt($(@).parent().find(".limit").attr("counter")) - 1
		$(@).parent().find(".limit").attr("counter", String(counter))
		if counter == 0
			$(@).hide()
		if counter != ($(@).parent().find(".slide").length - 7)
			$(@).parent().find(".right").show()
	slide_counter = $(".single-slide").length
	window.setInterval ->
		$("#limit").animate({"marginLeft":"-=283px"})
		slide_counter -= 1
		if slide_counter == 0
			$(".single-slide").hide()
			$("#limit").animate({"margin-left":"0"}, {duration: 1})
			$(".single-slide").show()
			slide_counter = $(".single-slide").length
	,5000
	toggle = true
	$("#subscribe").click ->
		if toggle
			$(@).parent().animate({"top": "-=40px"})
			toggle = false
		else
			$(@).parent().animate({"top": "+=40px"})
			toggle = true