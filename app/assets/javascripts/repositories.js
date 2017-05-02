  $(document).on('turbolinks:load', function() {
      $("#menu-list").click(function() {
          $(".traversal").show();
          $(".pannels").hide();
      });
      $('.folder>span').click(function() {
          $(this).next('.list').slideToggle();
          $(this).parent('li.folder').toggleClass("folder_down");
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
            for(i=0; i<result.length; i++){
              $('.search-result').append("<a class=link href= # rel= " + JSON.stringify(result[i]['filename'])+
               "dataurl=" + JSON.stringify(result[i]['value']) + ">"
              + (JSON.stringify(result[i]['filename']).replace('"','')).replace('"','') + "</a>");
            }
          }
      });
      $("a.link").click(function(event) {
        event.preventDefault();
        addTab($(this));
        if (window.innerWidth <= 700) {
          $('.traversal').css('display', 'none');
          $('.pannels').css('display', 'block');
        }
      });
  });

  function addTab(link) {
      $("#tabs li").removeClass("current");
      $("#tabs-editor li").removeClass("current");
      $('#tabs').append("<li class=current id = " + $(link).attr('rel') + "><div class=tab-wrapper><a class=tab id='" + $(link).attr("rel") +
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
