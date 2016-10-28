class Favorite {
  constructor(new_favorite, question_id, question){
    this.new_favorite = new_favorite;
    this.question_id = question_id;
    this.question = question;
    this.favorited = "Favorite";
  };
  thankUser() {
    alert("Question has been added to your favorites!");
  };
  changeButton() {
    this.favorited = "    <3    ";
  };
};

$(function(){
  $('form.favorite').submit(function(event) {
    var path = event.target.getAttribute('action');
    $.post(path, function(favoriteJSON) {      
      var favorite = new Favorite(favoriteJSON.new_favorite, favoriteJSON.question_id, favoriteJSON.question);
      // debugger;
      if(favorite.new_favorite){
        favorite.thankUser();
        favorite.changeButton();
      }
      $('form.favorite#question-' + favorite.question_id + ' :submit').val(favorite.favorited + " | " + favorite.question.favorite_count);
    });
    event.preventDefault();
  });
});