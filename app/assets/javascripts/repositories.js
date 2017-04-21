$(document).on('turbolinks:load', function() {
    $('.folder>span').click(function() {
        $(this).next('.list').slideToggle();
        $(this).parent('li.folder').toggleClass("folder_down");
    });
    $("a.link").click(function(event) {
        event.preventDefault();
        addTab($(this));
    });
});

function addTab(link) {
    $("#tabs li").removeClass("current");
    $('#tabs').append("<li class=current><div class=tab-wrapper><a class=tab id='" +
        $(link).attr("rel") + "'href='#'>" + $(link).html() +
        "</a><a href='#'class='remove'>x</a> </div><div id=editor-'" + $(link).attr("rel") + "' class='editor'></div></li>");
    var name = "editor-'" + $(link).attr("rel") + "'";
    console.log(name);
    var editor = ace.edit(name);
    var url = $(link).attr("dataurl");
    console.log(url);
    $.ajax({
        url: url,
        type: 'GET',
        dataType: 'text',
        success: function(data) {
            console.log(data);
            editor.setValue(data);
        },
        error: function(xhr, status, error) {
            console.log(status);
            console.log(error);
        }
    });
    $('#tabs a.tab').on('click', function(e) {
        e.preventDefault();
        var active = $(this).parent().parent();
        $('#tabs li').removeClass("current");
        $(active).addClass("current");
    })
    $('#tabs a.remove').on('click', function(e) {
        e.preventDefault();
        $('#tabs li').removeClass("current");
        var tabid = $(this).parent().find(".tab").attr("id");
        var Parent = $(this).parent();
        $(Parent).parent('li').prev('li').addClass("current");
        $(Parent).parent().remove();
    });
}
