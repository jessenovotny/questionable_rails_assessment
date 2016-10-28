$(function(){
  $('form.favorite').submit(function(event) {
    var path = event.target.getAttribute('action');
    $.post(path, function(favorite) {
    debugger;
      $('form.favorite#question-' + favorite.question_id + ' :submit').val("Favorite | " + favorite.question.favorite_count);
    });
    event.preventDefault();
  });
});