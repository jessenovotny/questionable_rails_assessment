QUESTIONABLE

## APPLICATION DESCRIPTION ##

Questionable is a personal project designed to display my personal abilities creating a rails application from scratch. It is based off of the popular Q & A platform Quora.com, allowing users to ask questions, answer other users's questions, 'upvote' other user's answers and 'favorite' questions. 

From the home page you may fiter questions by those which are oldest, newest, most popular (favorited), have the most upvoted answers, and by category. 

The categories (along with most users, questions, & answers) are all generated with the Faker gem, however when creating, editing, or even viewing another user's question, one can create new categories and apply them to the question at hand. To remove a category from a question, simply navigate to the question's show page and click on the category you'd like to remove. That category will then reappear in the dropdown of categories to add. 

To delete your account, navigate to your "Favorited Q's" usin the navbar link and find the Delete Account button below.


## INSTALLATION GUIDE ##

This application is live for production at www.questionable-on-rails.herokuapp.com

You may also run the application locally by running the following commands in your shell:

1. `git clone git@github.com:jessenovotny/questionable_rails_assessment.git`
2. `bundle`
2. `rake db:migrate`
3. `rake db:seed`
4. `rails s`

In your browser, navigate to http://localhost:3000/
Be aware that Facebook login will not function locally since my Facebook app ID and secret are not public on the remote repo. 


## CONTRIBUTOR'S GUIDE ##

Any and all pr's are welcome and encouraged. If you find a bug, feel free to submit any fixes :)

## LICENSING ##

