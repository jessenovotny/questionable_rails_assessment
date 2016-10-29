# Specifications for the Rails with jQuery Assessment

Specs:
- [x] Use jQuery for implementing new requirements
- [x] Include a show resource rendered using jQuery and an Active Model Serialization JSON backend.
<!-- click to show more of truncated answer -->
- [x] Include an index resource rendered using jQuery and an Active Model Serialization JSON backend.
<!-- found it more appropriate to render partials using jQuery for index resources -->
- [x] Include at least one has_many relationship in information rendered via JSON and appended to the DOM.
<!-- answers has_many upvotes; questions has_many favorites and answers -->
favorites
- [x] Include at least one link that loads or updates a resource without reloading the page.
<!-- eliminated answers new and edit view using buttons to show answer form in question show -->
- [x] Translate JSON responses into js model objects.
<!-- see favorites.js  -->
- [x] At least one of the js model objects must have at least one method added by your code to the prototype.
<!-- see favorites.js -->

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message 
<!-- I could have done better with this one -->


Assessment
- build a lazy loader or paginate questions#index
- maybe use handlebar templates in place of partials