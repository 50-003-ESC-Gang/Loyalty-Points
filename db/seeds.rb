# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

10.times do |i|
    loyalty_program = LoyaltyProgram.create(
        loyalty_program_id: "id#{i}",
        program_name: "Loyalty Program #{i}",
        currency_name: "Currency $#{i}",
        processing_time: "2000-01-01 02:00:00",
        description: "Test Description",
        enrollment_link: "www.google.com",
        terms_and_conditions_link: "www.facebook.com" 
    )
    user = User.create(email: "#{i}@gmail.com", password: "123456", name: "User #{i}", lastname: "Lastname #{i}")
    account = Account.create(user_id: i)
    txn = Transaction.create(loyalty_program_data_id: i, amount: i, date: "2000-01-01 02:00:00", status: 0, account: account)

  end
