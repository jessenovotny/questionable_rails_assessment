// click "Upvote" to create upvote and show updated upvote count
$(function(){
  $('form.upvote').on('submit', function(event) {
    var path = event.target.getAttribute('action');
    $.post(path, function(data) {
      $('form#answer-' + data.answer_id + ' :submit').val("Upvote | " + data.answer.upvote_count);
    });
    return false;
  });
});