function addTab(link) {
    $("#tabs li").removeClass("current");
    $("#tabs-editor li").removeClass("current");
    $('#tabs').append("<li class=current id = " + $(link).attr('rel') +
        "><div class=tab-wrapper><a class=tab id='" + $(link).attr("rel") +
        "' href='#'>" + $(link).attr('rel') + "</a><a id = '" +
        $(link).attr("rel") + "'href='#'class='remove'>x</a> </div></li>");
    $('#res-tab').append("<option value= " + $(link).attr('rel') + ">" +
        $(link).attr('rel') + "</option>");
    $('#tabs-editor').append("<li class=current id = '" + $(link).attr("rel") +
        "'><div id='editor-" + $(link).attr("rel") + "' class='editor'></div></li>");
    var name = "editor-" + $(link).attr("rel");
    var editor = ace.edit(name);
    var url = $(link).attr("dataurl");
    var path = $(link).attr("rel");
    var modelist = ace.require("ace/ext/modelist");
    var mode = modelist.getModeForPath(path).mode;
    console.log(mode);
    editor.session.setMode(mode);
    editor.setTheme('ace/theme/twilight');
    console.log(path);
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
    $(function() {
        $('#res-tab').on('change', function() {
            var current = $(this).find(':selected').text();
            $('#tabs li').removeClass("current");
            $('#tabs-editor li').removeClass("current");
            $('#tabs li').each(function() {
                if ($(this).attr('id') == current) {
                    console.log("aah chalea");
                    $(this).addClass("current");
                }
            });
            $('#tabs-editor li').each(function() {
                if ($(this).attr('id') == current) {
                    $(this).addClass("current");
                }
            });
            console.log(current);
        });
        $('#tabs a.tab').on('click', function(e) {
            e.preventDefault();
            var current = $(this);
            console.log("current=" + $(current).attr('id'));
            $('#tabs li').removeClass("current");
            $('#tabs-editor li').removeClass("current");
            $(this).parent().parent('li').addClass("current");
            $('#tabs-editor li').each(function() {
                console.log($(this).attr('id'));
                if ($(this).attr('id') == $(current).attr('id')) {
                    $(this).addClass("current");
                }
            });
        });
        $('#tabs a.remove').on('click', function(e) {
            e.preventDefault();
            var current = $(this);
            var newli = $(this).parent().parent('li').prev('li');
            $(this).parent().parent('li').prev('li').addClass("current");
            $('#tabs-editor li').each(function() {
                if ($(this).attr('id') == $(newli).attr('id')) {
                    $(this).addClass("current");
                }
            });
            $('#res-tab option').each(function() {
                if ($(this).attr('value') == $(current).attr('id')) {
                    $(this).remove();
                }
            });
            $(this).parent().parent('li').remove();
            $('#tabs-editor li').each(function() {
                if ($(this).attr('id') == $(current).attr('id')) {
                    $(this).remove();
                }
            });
        });
    });
}
