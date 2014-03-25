//= require jquery
//= require jquery_ujs
//= require codemirror
//= require codemirror/addons/mode/overlay
//= require codemirror/modes/gfm
//= require codemirror/modes/markdown
//= require codemirror/modes/ruby
//= require codemirror/modes/javascript
//= require_self

$(function(){
  $(window).resize(doResize);
  doResize();
});

function doResize() {
  var cm = $('body, .CodeMirror');
  cm.height(0);
  cm.height($(document).height());
}
