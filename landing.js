$("#search_field").focus(function() {
  $(this).css('font-family','Wingdings');
});

$("#search_field").focusout(function() {
  if ($(this).attr("value").length == 0) {
    $(this).css('font-family','Century Gothic');
  }
});
