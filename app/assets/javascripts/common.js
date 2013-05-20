$(document).ready(function() {
  //We add a custom data-toggle target since there is no way for CSS to specify
  //the next element. From: http://goo.gl/dMIDh
  $('body').on('click.collapse-next.data-api', '[data-toggle=collapse-next]', function (e) {
    var $target = $(this).parent().next();
    $target.data('collapse') ? $target.collapse('toggle') : $target.collapse();
    e.preventDefault();
  });
});
