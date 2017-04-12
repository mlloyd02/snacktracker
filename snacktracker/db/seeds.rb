# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

pop_rocks = OptionalSnack.create(name: 'Pop Rocks', last_purchase_date: '2/12/2017', api_id: 1234)
milky_way = OptionalSnack.create(name: 'Milky Way', last_purchase_date: '2/12/2017', api_id: 1235)
rope_licorice = OptionalSnack.create(name: 'Rope Licorice', last_purchase_date: '2/12/2017', api_id: 1236)
candy_cigarettes = OptionalSnack.create(name: 'Candy Cigarettes', last_purchase_date: '2/12/2017', api_id: 1237)
big_league_chew = OptionalSnack.create(name: 'Big League Chew', last_purchase_date: '2/12/2017', api_id: 1238)

pop_rocks_suggestion1 = pop_rocks.suggestions.create
pop_rocks_suggestion2 = pop_rocks.suggestions.create(created_at: 1.month.ago)
milky_way_suggestion1 = milky_way.suggestions.create
milky_way_suggestion2 = milky_way.suggestions.create(created_at: 1.month.ago)
rope_licorice_suggestion1 = rope_licorice.suggestions.create
candy_cigarettes_suggestion1 = candy_cigarettes.suggestions.create
big_league_chew_suggestion1 = big_league_chew.suggestions.create

for i in 0..5
  pop_rocks_suggestion1.votes.create
end
for i in 0..10
  milky_way_suggestion1.votes.create
end
for i in 0..12
  rope_licorice_suggestion1.votes.create
end
for i in 0..4
  candy_cigarettes_suggestion1.votes.create
end
for i in 0..9
  big_league_chew_suggestion1.votes.create
end
