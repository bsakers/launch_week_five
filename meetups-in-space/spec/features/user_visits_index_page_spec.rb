require 'spec_helper'

feature 'user visits the meetups index page' do
  scenario 'user sees all meetups' do
    Meetup.create(name: "Dota Lan", description: "Play Dota", location: "Smoke den in Asia", creator: "RTZ");
    visit '/meetups'

    expect(page).to have_content('Dota Lan')
    expect(page).to have_link('Dota Lan')
  end
end
