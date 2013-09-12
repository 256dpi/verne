//= require jquery
//= require jquery_ujs
//= require_tree .
//= require codemirror
//= require codemirror/addons/mode/overlay
//= require codemirror/modes/gfm
//= require codemirror/modes/markdown
//= require codemirror/modes/ruby
//= require codemirror/modes/javascript

$(function(){
  $(window).resize(doResize);
  doResize();
});

function doResize() {
  cm = $("body, .CodeMirror");
  cm.height(0);
  cm.height($(document).height());
}