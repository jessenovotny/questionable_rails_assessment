$(function(){
  $(".js-more-answer").click(function(event){
    debugger;
    event.preventDefault();
    var answer = $(this).data("id")
    $.get("/answers/" + answer +".json" , function(data){
      $('a[data-id='+ data.id + ']').text(data.content)
    })
  }
})

// $(function(){
//   $(".js-more-answer").click(function(event){
//     event.preventDefault();
//     var answer = $(this).data("id")
//     $.get("/answers/" + answer +".json" , function(data){
//       $('a[data-id='+ data.id + ']').text(data.content)
//     })
//   }

//   $("form.new_answer_button").submit(function(event){
//     event.preventDefault();
//     var newAnswerFormPath = event.target.getAttribute('action')
//     $("form.new_answer_button").remove()
//     $.get(newAnswerFormPath, function(formPartial){
//       $("div.answer_form").html(formPartial);
//       $("form.new_answer").submit(function(event){
//         event.preventDefault();
//         var values = $(this).serialize();
//         var createAnswerPath = event.target.getAttribute('action')
//         $.post(createAnswerPath, values)
//         .done(function(answersPartial){
//           $('form.new_answer').remove();
//           $('ul.question_answers').html(answersPartial);
//           var question_id = this.url.split("/")[2]
//           $.get('/questions/' + question_id + '/options', function (options){          
//             $('div.question_options').html(options);
//             // deleteAnswer();
//             // editAnswer();
//           });
//         });
//       });
//     });
//   });
// });


// eliminate New Answer page - remove links to it located in _question_options and _question
// click "Submit Answer" to create/show answer
// click "Edit Answer" to replace answer with update form
// remove answers/new.html.erb 