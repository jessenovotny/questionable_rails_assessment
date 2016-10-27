// click to add/remove categories
var removeCategory = function(event){
  var path = event.target.getAttribute("href")
  var data = {"_method":"PUT"}
  $.ajax({url: path, type: 'PUT'})
  .done(function(categoriesPartial){
    $('div.question_categories').html(categoriesPartial);
    attachCategoryListeners();
  });
};

var attachCategoryListeners = function() {
  $('a.remove_category').click(function(event){
    removeCategory(event);
  })
}

$(function(){
  attachCategoryListeners();
})