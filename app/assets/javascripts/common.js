$(document).ready(function() {
  //We add a custom data-toggle target since there is no way for CSS to specify
  //the next element. From: http://goo.gl/dMIDh
  $('body').on('click.collapse-next.data-api', '[data-toggle=collapse-next]', function (e) {
    var $target = $(this).parent().next();
    $target.data('collapse') ? $target.collapse('toggle') : $target.collapse();
    e.preventDefault();
  });

  //When accordion elements are expanded or collapsed, we need to grab entry data
  //through ajax or destroy the loaded content.
  $('#items').on('show', function(e) {
    var entry_id = '#' + e.target.id; //e.g. #entry-845
    var id = parseInt(entry_id.split('-')[1]);
    var url = '/entries/' + id.toString();
    $.getJSON(url, function(data) {
      //console.log(data);
      $(entry_id).find('.entry-title a').attr('href', data.url).text(data.title);
      if(data.author) {
        $(entry_id).find('.entry-author').text('by ' + data.author);
      }
      $(entry_id).find('.entry-body').html(data.content);
    });
  });

  //NOTE: The problem with this approach is that we need to manually zero out
  //each attribute, which is not elegant.
  $('#items').on('hidden', function(e) {
    var entry_id = '#' + e.target.id; //e.g. #entry-845
    $(entry_id).find('.entry-title a').attr('href', null).text(null);
    $(entry_id).find('.entry-author').text(null);
    $(entry_id).find('.entry-body').text(null);
  });
});
