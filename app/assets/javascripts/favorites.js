var currentPage = function(){
  var page = window.location.href.split("/")
  return page[page.length - 1]
}

function Favorite(new_favorite) {
  this.new_favorite = new_favorite;
  this.favorited = "Favorite";
};

Favorite.prototype.thankUser = function() {
    alert("Question has been added to your favorites!");
};

Favorite.prototype.changeButton = function() {
  this.favorited = "    <3    ";
};

function Question(favoriteCount, id) {
  this.favoriteCount = favoriteCount;
  this.id = id
}

$(function(){
  $('form.favorite').submit(function(event) {

    var path = event.target.getAttribute('action');
    $.post(path, function(response) {      
      
      if(currentPage() == "favorites"){
        return location.reload();
      }
      
      var favorite = new Favorite(response[0].new_favorite);
      var question = new Question(response[1].favorites.length, response[1].id);

      if(favorite.new_favorite){
        favorite.changeButton();
      };
      
      $('form.favorite#question-' + question.id + ' :submit').val(favorite.favorited + " | " + question.favoriteCount);
    });
    event.preventDefault();
  });
});