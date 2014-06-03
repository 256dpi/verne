//= require jquery
//= require jquery_ujs
//= require codemirror
//= require codemirror/addons/mode/overlay
//= require codemirror/modes/gfm
//= require codemirror/modes/markdown
//= require codemirror/modes/ruby
//= require codemirror/modes/javascript
//= require_self

// Add CMD+E handler
$(function(){
  $('li.edit').each(function(){
    $(window).keydown(function(e) {
      if (e.metaKey && e.keyCode == 69) {
        document.location.href = $('li.edit a').attr('href');
        e.preventDefault();
        return false;
      }
    });
  });
});

// Add CMD+S handler
$(function(){
  $('li.save').each(function(){
    var editor = CodeMirror.fromTextArea($("#code").get(0), {
      mode: "gfm",
      lineNumbers: false,
      matchBrackets: true,
      tabSize: 2,
      theme: "pastel-on-dark",
      lineWrapping: true
    });
    $(function(){
      editor.refresh();
    });
    $(window).keydown(function(e) {
      if (e.metaKey && e.keyCode == 83) {
        $('form').submit();
        e.preventDefault();
        return false;
      }
    });
    $(this).click(function(){
      $('form').submit();
    })
  });
});

// Make CodeMirror fullscreen
$(function(){
  function doResize() {
    var cm = $('body, .CodeMirror');
    cm.height(0);
    cm.height($(document).height());
  }

  $(window).resize(doResize);
  doResize();
});
