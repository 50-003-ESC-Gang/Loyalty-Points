# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

### Setup

```bash
git clone https://github.com/50-003-ESC-Gang/Loyalty-Points.git
rvm install 3.0.3
bundle install
rails db:create
rails db:migrate
rails tailwindcss:install
```

Database setup

```bash
rake db:drop
rake db:migrate
rake db:seed
```

View all DB tables : `ActiveRecord::Base.connection.tables`

### Commands for running

To turn on the server : `rails s`

To use console for debugging : `rails c`

### Testing commands

To run the specs, type:

```
bundle exec rspec
```

Libraries used for testing

* rspec
* faker
* factory_bot <https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md#associations>

### Issues with Setting up

1. problem :
Error when trying to run rspec: `require': cannot load such file -- rails_helper (LoadError)
solution :`rails generate rspec:install`

source :
<https://stackoverflow.com/questions/25800122/error-when-trying-to-run-rspec-require-cannot-load-such-file-rails-helper>

### Contribution Steps

Want to help us out? Here are some steps to make sure you are contributing according to our guidelines.

1. Find an issue you like, or create a new issue [here](https://github.com/50-003-ESC-Gang/Loyalty-Points/issues)
    * Please ask for any questions or clarifications in the associated issues or in new issues! 🤔
2. Assign yourself to the issue and create a branch , following GitHub Issue's naming scheme. 🛠️
    * The naming scheme should follow (`#featureNumber-issue-name`) ie. (#f1-create-new-model)
3. Get on your local machine and [ensure you have the repo cloned](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository). Checkout the branch you just made with `git checkout branch-name` and pull the latest merged changes from the repo with `git pull origin main` to make sure you have the most up-to-date code from the repo. 👩‍💻
4. Add your amazing changes along with any documentation you feel would be useful (ie. Update the README if necessary). Then commit and push your changes. 🌟
5. Go back to the repo on GitHub and create a pull request! Then wait for an admin of the repo to get back to your pull request, address any comments, and once you are finally approved, merge your code! 🎉

If you want some more tips on contributing to GitHub projects, [check out this resource from Data School](https://www.dataschool.io/how-to-contribute-on-github/).
