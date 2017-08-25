# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Example:
#
#   Person.create(first_name: 'Eric', last_name: 'Kelly')
Meetup.destroy_all;
Meetup.create(name: "Dota Lan", description: "Play Dota", location: "Smoke den in Asia", creator: "RTZ");
Meetup.create(name: "Soccer", description: "4 on 4 street soccer", location: "Roller Rink in Jersey", creator: "Eric M.")
