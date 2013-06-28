//= require jquery
//= require jquery_ujs
//= require_self
//= require_tree .
//= require codemirror
//= require codemirror/addons/mode/overlay
//= require codemirror/modes/gfm
//= require codemirror/modes/markdown
//= require codemirror/modes/ruby
//= require codemirror/modes/javascript

$(document).ready(function(){
  $(window).resize(doResize);
  doResize();
});

function doResize() {
  $("body, .CodeMirror").height(0);
  $("body, .CodeMirror").height($(document).height());
}