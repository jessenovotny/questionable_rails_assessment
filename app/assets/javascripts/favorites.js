// click "Favorite" to create favorite and update favorite count.
$(function(){
  $('form.favorite').on('submit', function(event) {
    var path = event.target.getAttribute('action');
    $.post(path, function(data) {
      $('form#question-' + data.question_id + ' :submit').val("Favorite | " + data.question.favorite_count);
    });
    return false;
  });
});