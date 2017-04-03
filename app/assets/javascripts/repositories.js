$(document).ready(function(){
  $('.folder>span').click(function() {
    console.log("chalpyaaaa");
    $(this).next('.list').slideToggle();
    return false;
  });

    var editor = ace.edit("editor");
    $("a.file").click(function(event){
      event.preventDefault();
      var url=$(this).attr("dataurl");
      $.ajax({
        url:url,
        type:'GET',
        dataType: 'text',
        success: function(data){
          $(".ace_content").html(data);
        },
        error:function(xhr,status,error){
          console.log(status);
          console.log(error);
        }
      });
    });
});
