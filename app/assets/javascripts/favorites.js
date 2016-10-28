var currentPage = function(){
  var page = window.location.href.split("/")
  return page[page.length - 1]
}

class Favorite {
  constructor(new_favorite){
    this.new_favorite = new_favorite;
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
    $.post(path, function(response) {      
      
      var favorite = new Favorite(response[0].new_favorite);
      var question = response[1];

      if(favorite.new_favorite){
        favorite.changeButton();
      };
      
      $('form.favorite#question-' + question.id + ' :submit').val(favorite.favorited + " | " + question.favorites.length);
      if(currentPage() == "favorites"){
        location.reload();
      }
      // debugger;
    });
    event.preventDefault();
  });
});