$(document).ready(function(){
  $('li.folder').click(function() {
    $(this).children('ul.list').slideToggle(' ');
    return(false);
  });

    var editor = ace.edit("editor");

    $("a.file").click(function(event){
      event.preventDefault();
      var url=$(this).attr("dataurl");
      $.ajax({
        url:url,
        type: "GET",
        success:function(data){
          console.log(data);
          $(".ace_content").html(data);
        }
      });
    });
  });
