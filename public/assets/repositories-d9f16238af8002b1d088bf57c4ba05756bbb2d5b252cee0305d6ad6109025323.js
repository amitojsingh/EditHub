var editor = ace.edit("editor");

$(function(){
  $("ul.list").hide();

  $("li").click(function() {
    $(this).children('ul.list').slideToggle();
    return false;
  });
});

    $("a.file").click(function(event){
      event.preventDefault();
  var url=$(this).attr("dataurl");
  $.ajax({
    url:url,
    type: "GET",
    success:function(data){
      console.log(data)
      $(".ace_content").html(data);
    }
  });
});
