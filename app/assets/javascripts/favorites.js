// click "Favorite" to create favorite and update favorite count.
$(function(){
  $('form.favorite').submit(function(event) {
    event.preventDefault();
    var path = event.target.getAttribute('action');
    $.post(path, function(data) {
      $('form.favorite#question-' + data.question_id + ' :submit').val("Favorite | " + data.question.favorite_count);
    });
  });
});