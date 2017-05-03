  $(document).on('turbolinks:load', function() {
        $("#menu-list").click(function() {
            $(".traversal").show();
            $(".pannels").hide();
        });
        $('.folder>span').click(function() {
            $(this).next('.list').slideToggle();
            $(this).parent('li.folder').toggleClass("folder_down");
        });
        $("body").on('click','.link',function(event) {
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
                }
                $('.search-result a').remove();
                $('.search').val('');
              }
                else {
                  var current = $(this).attr('rel');
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
                }
        });
        var list = [];
        $('.traversal ul li > a').each(function() {
            var file = $(this).attr('rel');
            var val = $(this).attr('dataurl');
            var data = {
                'filename': file,
                'value': val
            };
            list.push(data);
            console.log(JSON.stringify(list));
        });
        var option = {
            keys: ['filename']
        };
        var fuse = new Fuse(list, option);
        $('.search').on('input', function() {
          var result = fuse.search($(this).val());
            for (var i = 0; i < result.length; i++) {
                $('.search-result a').remove();
                for (i = 0; i < result.length; i++) {
                    $('.search-result').append("<a class=link href= # rel= " + JSON.stringify(result[i]['filename']) +
                        "dataurl=" + JSON.stringify(result[i]['value']) + ">" +
                        (JSON.stringify(result[i]['filename']).replace('"', '')).replace('"', '') + "</a>");
                }
            }
        });
  });
