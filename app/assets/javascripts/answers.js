var showMoreAnswer = function(event){
  var answer_id = event.target.getAttribute("id")
  $.get("/answers/" + answer_id + ".json", function(answer){
    $('p#' + answer.id).text(answer.content)
  });
  event.preventDefault();
};

var updatePartials = function(answersPartial, thisPage){
  $('div.question_answers').html(answersPartial);
  $('form.upvote').submit(function(event) {
    updateUpvote(event);
  });
  var question_id = thisPage.url.split("/")[2]
  $.get('/questions/' + question_id + '/options')
  .done(function (options){  
    $('div.question_options').html(options);
    attachAnswersListeners();
  });
};

var createAnswer = function(values, event){
  var path = event.target.getAttribute('action')
  $.post(path, values)
  .done(function(answersPartial){
    updatePartials(answersPartial, this);
  });
  event.preventDefault();
};

var updateAnswer = function(values, event){
  var path = event.target.getAttribute('action')
  $.post(path, values)
  .done(function(answersPartial){
    updatePartials(answersPartial, this);
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
    updatePartials(answersPartial, this);
  })  
  event.preventDefault()
}

var updateUpvote = function(event){
  var path = event.target.getAttribute('action');
  $.post(path, function(upvote) {
    $('form#answer-' + upvote.answer_id + ' :submit').val("Upvote | " + upvote.answer.upvote_count);
  });
  event.preventDefault();
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
