var showMoreAnswer = function(event){
  var answer_id = event.target.getAttribute("id")
  $.get("/answers/" + answer_id + ".json", function(answer){
    $('p#' + answer.id).text(answer.content)
  });
  event.preventDefault();
};

var createAnswer = function(values, event){
  var path = event.target.getAttribute('action')
  $.post(path, values)
  .done(function(answersPartial){
    $('form.new_answer').remove();
    $('div.question_answers').html(answersPartial);
    let question_id = this.url.split("/")[2]
    $.get('/questions/' + question_id + '/options', function (options){          
      $('div.question_options').html(options);
    attachAnswersListeners();
    });
  });
  event.preventDefault();
};

var updateAnswer = function(values, event){
  var path = event.target.getAttribute('action')
  $.post(path, values)
  .done(function(answersPartial){
    $('form.edit_answer').remove();
    $('div.question_answers').html(answersPartial);
    let question_id = this.url.split("/")[2]
    $.get('/questions/' + question_id + '/options')
    .done(function (options){  
      $('div.question_options').html(options);
      attachAnswersListeners();
    });
  });
  event.preventDefault();
};


var showAnswerForm = function(event) {
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
  event.preventDefault()
};

var showFirstAnswerForm = function(event) {
  var newAnswerFormPath = event.target.getAttribute('action')
  $("form.first_answer_button").remove()
  $.get(newAnswerFormPath, function(formPartial){
    $("div.answer_form").html(formPartial);
    $('<input>').attr({
      type: 'hidden',
      name: 'first_answer',
      value: true
    }).appendTo("form.new_answer")
  });
  event.preventDefault()
};

var deleteAnswer = function(event){
  var answerDeletePath = event.target.getAttribute('action')
  var data = {"_method":"delete"}
  $.post(answerDeletePath, data)
  .done(function(answersPartial){
    $('div.question_answers').html(answersPartial);
    let question_id = this.url.split("/")[2]
    $.get('/questions/' + question_id + '/options')
    .done(function (options){  
      $('div.question_options').html(options);
      attachAnswersListeners();
    });
  })  
  event.preventDefault()
}

var attachAnswersListeners = function(){
  $("p.js-more-answer").click(function(event){
    showMoreAnswer(event);
  });
  $("form.new_answer_button").submit(function(event){
    showAnswerForm(event);
  });
  $("form.first_answer_button").submit(function(event){
    showFirstAnswerForm(event);
  })
  $("form.edit_answer_button").submit(function(event){
    showAnswerForm(event);
  });
  $("form.delete_answer_button").submit(function(event){
    deleteAnswer(event);
  })
};


$(function(){
  attachAnswersListeners();
});

// eliminate New Answer page - remove links to it located in _question_options and _question *** Already done with question_options
// remove answers/new.html.erb 