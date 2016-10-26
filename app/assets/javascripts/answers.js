$(function() {
// click truncated answer to expand
  $(".js-more-answer").on('click', function(){
    var answer = $(this).data("id")
    $.get("/answers/" + answer +".json" , function(data){
      $('a[data-id='+ data.id + ']').text(data.content)
    })
    return false;
  })

// click "Andswer Question" to display form
  $("a.new_answer").on('click', function() {
    debugger;
    $("div.new_answer")
    return false;
  })

  $("form.new_answer_button").on('submit', function(event){
    event.preventDefault();
    var newAnswerFormPath = event.target.getAttribute('action')
    $.get(newAnswerFormPath, function(formPartial){
      $("div.new_answer").html(formPartial);
    });
  });

  $("form.new_answer").on('submit', function(event){
    debugger;
    event.preventDefault();
    var createAnswerPath = event.target.getAttribute('action')
    $.post(createAnswerPath, function(answersPartial){
      debugger;
    })
  })
});


// eliminate New Answer page - remove links to it located in _question_options and _question
// click "Submit Answer" to create/show answer
// click "Edit Answer" to replace answer with update form
// remove answers/new.html.erb 