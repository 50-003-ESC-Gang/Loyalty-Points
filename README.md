# README


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

Selenium

1. Download driver at <https://chromedriver.chromium.org/downloads>
2. Copy the driver to the root of the project
3. Change path of the driver 

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

## Application

### Features:
- Feature 1: Provide loyalty programs Information 
- Feature 2: Loyalty Program Membership Validation
- Feature 3: Process Accrual Information
- Feature 4: Retrieve transaction details
- Feature 5: Transfer fulfillments
- Feature 6: Display changes and available options
- Feature 7:  Points valuations & Promotions

### Sequence Digrams

<img width="568" alt="image" src="https://user-images.githubusercontent.com/46377366/199053098-2cdde7f0-d635-4a69-b9a7-62bc8755b86a.png">

### Class Digram

<img width="594" alt="image" src="https://user-images.githubusercontent.com/46377366/199053189-7d595596-c199-4cf7-b19e-542e08c45de9.png">




