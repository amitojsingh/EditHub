$(document).on('turbolinks:load',function(){
  $('.folder>span').click(function() {
    console.log("chalpyaaaa");
    $(this).next('.list').slideToggle();
    console.log(this);
    $(this).parent('li.folder').toggleClass("folder_down");
    console.log(this);
  });
var editor = ace.edit("editor");
    $("a.link").click(function(event){
      event.preventDefault();
      var url=$(this).attr("dataurl");
      console.log(url);
      $.ajax({
        url:url,
        type:'GET',
        dataType: 'text',
        success: function(data){
          console.log(data);
          editor.setValue(data);
        },
        error:function(xhr,status,error){
          console.log(status);
          console.log(error);
        }
      });
    });
});
