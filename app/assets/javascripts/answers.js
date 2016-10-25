// click truncated answer to expand
$(function() {
  $(".js-more-answer").on('click', function(){
    var answer = $(this).data("id")
    $.get("/answers/" + answer +".json" , function(data){
      $('a[data-id='+ data.id + ']').text(data.content)
    })
    return false;
  })
})

// click "Answer Question" to display form
// click "Submit Answer" to create/show answer
// click "Edit Answer" to replace answer with update form
// remove answers/new.html.erb 