# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# #   Character.create(name: "Luke", movie: movies.first)
# program_names = ["Gojet Points", "Ascendas Points", "Starbucks Points", "Disney Points", "Lucky Start Points", "KFC Points", "Macdonald Points", "SUTD Score", "A&W Points", "Changi City Points", "Proper12dsmca Points" ]
# loyalty_programs_ids = ["GOPOINTS", "ASCENDAPOINTS", "STARBUCCAPOINTS", "DISNEYPOINTS", "LUCKYSTARTPOINTS", "KFCPOINTS", "MACDONALDPOINTS", "SUTDSPOINTS", "AWPOINTS", "CHANGICITYPOINTS", "PROPER12DSMCA"]
# currency_names = ["GoPoints", "Ascendas Points", "Starbucks Points", "Disney Points", "Lucky Start Points", "KFC Points", "Macdonald Points", "SUTD Score", "A&W Points", "Changi City Points", "Proper12dsmca Points"]

# 10.times do |i|
#     loyalty_program = LoyaltyProgram.create(
#     loyalty_program_id: "#{loyalty_programs_ids[i]}",
#     program_name: "#{program_names[i]}",
#     currency_name: "#{currency_names[i]}",
#     processing_time: '2000-01-01 02:00:00',
#     description: 'Test Description',
#     enrollment_link: 'www.google.com',
#     terms_and_conditions_link: 'www.facebook.com'
# )
# end

# # Create loyalty program data for every user once all loyalty program have been created
# 10.times do |i|
#   user = User.create(email: "#{i}@gmail.com", password: '123456', name: "User #{i}", lastname: "Lastname #{i}")

#   txn = Transaction.create(loyalty_program_datum_id: i, amount: 100, created_at: '2000-01-01 02:00:00', status: 'pending',
#                            account_id: i)
# end

# puts 'Seeding done!'

program_names = ['Gojet Points', 'Ascendas Points', 'Starbucks Points', 'Disney Points', 'Lucky Start Points',
                 'KFC Points', 'Macdonald Points', 'SUTD Score', 'A&W Points', 'Changi City Points', 'Proper12dsmca Points']
loyalty_programs_ids = %w[GOPOINTS ASCENDAPOINTS STARBUCCAPOINTS DISNEYPOINTS LUCKYSTARTPOINTS
                          KFCPOINTS MACDONALDPOINTS SUTDSPOINTS AWPOINTS CHANGICITYPOINTS PROPER12DSMCA]
currency_names = ['GoPoints', 'Ascendas Points', 'Starbucks Points', 'Disney Points', 'Lucky Start Points',
                  'KFC Points', 'Macdonald Points', 'SUTD Score', 'A&W Points', 'Changi City Points', 'Proper12dsmca Points']

10.times do |i|
  loyalty_program = LoyaltyProgram.create(
    loyalty_program_id: i,
    program_name: (program_names[i]).to_s,
    currency_name: (currency_names[i]).to_s,
    processing_time: '2000-01-01 02:00:00',
    description: 'Test Description',
    enrollment_link: 'www.google.com',
    terms_and_conditions_link: 'www.facebook.com'
  )

  user = User.create(email: "#{i}@gmail.com", password: '123456', name: "User #{i}", lastname: "Lastname #{i}")

  txn = Transaction.create(loyalty_program_datum_id: i, amount: 100, created_at: '2000-01-01 02:00:00', status: 'pending',
                           account_id: i)
end

puts 'Seeding done!'
