// click "Favorite" to create favorite and update favorite count.
$(function(){
  $('form.favorite').submit(function(event) {
    var path = event.target.getAttribute('action');
    $.post(path, function(favorite) {
      $('form.favorite#question-' + favorite.question_id + ' :submit').val("Favorite | " + favorite.question.favorite_count);
    });
    event.preventDefault();
  });
});