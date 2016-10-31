var updateUpvote = function(event){
  var path = event.target.getAttribute('action');
  $.post(path, function(upvote) {
    $('form#answer-' + upvote.answer_id + ' :submit').val("Upvote | " + upvote.answer.upvote_count);
  });
  event.preventDefault();
}

$(function(){
  // debugger;
  $('form.upvote').submit(function(event) {
    updateUpvote(event);
  });
});