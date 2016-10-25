// click "Upvote" to create upvote and show updated upvote count
$(function(){
  $('form.upvote').on('submit', function(event) {
    event.preventDefault();
    var path = event.target.getAttribute('action');
    $.post(path, function(data) {
      debugger;
      $('form.answer-' + data.answer_id)
      
    })
    // debugger;
  })
})