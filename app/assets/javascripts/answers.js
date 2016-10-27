var showMoreAnswer = function(event){
  event.preventDefault();
  var answer_id = event.target.getAttribute("id")
  $.get("/answers/" + answer_id + ".json", function(answer){
    $('a#' + answer.id).text(answer.content)
  });
};

var createAnswer = function(values, event){
  event.preventDefault();
  var path = event.target.getAttribute('action')
  $.post(path, values)
  .done(function(answersPartial){
    $('form.new_answer').remove();
    $('ul.question_answers').html(answersPartial);
    let question_id = this.url.split("/")[2]
    $.get('/questions/' + question_id + '/options', function (options){          
      $('div.question_options').html(options);
      $("form.edit_answer_button").submit(function(event){
        event.preventDefault();
        showAnswerForm(event);
      });
      // deleteAnswer();
    });
  });
};

var updateAnswer = function(values, event){
  event.preventDefault();
  var path = event.target.getAttribute('action')
  $.post(path, values)
  .done(function(answersPartial){
    $('form.edit_answer').remove();
    $('ul.question_answers').append(answersPartial);
    let question_id = this.url.split("/")[2]
    $.get('/questions/' + question_id + '/options')
    .done(function (options){  
      $('div.question_options').html(options);
      // must reload the page before you can click "edit" again...
      // even if attachListeners is called again.
    });
  });
}


var showAnswerForm = function(event) {
  event.preventDefault()
  var answerFormPath = event.target.getAttribute('action')
  $("form.new_answer_button").remove()
  $.get(answerFormPath, function(formPartial){
    $("div.answer_form").html(formPartial);
    $("form.new_answer").submit(function(event){
      var values = $(this).serialize();      
      createAnswer(values, event);
    });
    $("form.edit_answer").submit(function(event){
      var values = $(this).serialize();
      updateAnswer(values, event);
    })
  });
};

var deleteAnswer = function(event){
  event.preventDefault()
  var answerDeletePath = event.target.getAttribute('action')
  $.ajax({
    url: answerDeletePath,
    type: 'DELETE'
    success: function(answersPartial){
  debugger;
      $('ul.question_answers').append(answersPartial);
      let question_id = this.url.split("/")[2]
      $.get('/questions/' + question_id + '/options')
      .done(function (options){  
        $('div.question_options').html(options);
      }
    }
  })  
}

var attachListeners = function(){
  $(".js-more-answer").click(function(event){
    showMoreAnswer(event);
  });
  $("form.new_answer_button").submit(function(event){
    showAnswerForm(event);
  });
  $("form.edit_answer_button").submit(function(event){
    showAnswerForm(event);
  });
  $("form.delete_answer_button").submit(function(event){
    deleteAnswer(event);
  })
};


$(function(){
  attachListeners();
});

// $(function(){
//   $(".js-more-answer").click(function(event){
//     debugger;
//     event.preventDefault();
//     var answer = $(this).data("id")
    // $.get("/answers/" + answer +".json" , function(data){
    //   $('a[data-id='+ data.id + ']').text(data.content)
    // })
//   }
// })


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