$(function(){
  $('form.upvote').submit(function(event) {
    var path = event.target.getAttribute('action');
    $.post(path, function(upvote) {
      $('form#answer-' + upvote.answer_id + ' :submit').val("Upvote | " + upvote.answer.upvote_count);
    });
    event.preventDefault();
  });
});