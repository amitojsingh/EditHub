$("#menu-list").click(function() {
  $(".traversal").show();
  $(".pannels").hide();
});
$('.folder>span').click(function() {
  $(this).next('.list').slideToggle();
  $(this).parent('li.folder').toggleClass("folder_down");
});
$("a.link").click(function(event) {
  console.log("chal pya");
  event.preventDefault();
  var current = $(this).attr('rel');
  var bool = 0;
  $("ul#tabs li").each(function() {
    if ($(this).attr('id') == current) {
      bool++;
    }
  });
  if (bool == 0) {
    addTab($(this));
    if (window.innerWidth <= 700) {
      $('.traversal').css('display', 'none');
      $('.pannels').css('display', 'block');
    } else {
      return 0;
    }
  }
});
  $(document).on('turbolinks:load', function() {
  });
