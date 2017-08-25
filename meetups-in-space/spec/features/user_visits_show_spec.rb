require 'spec_helper'

feature 'user visits meeting show page' do
  let!(:meetup) {Meetup.create(name: "Soccer", description: "4 on 4 street soccer", location: "Roller Rink in Jersey", creator: "Eric M.")}

  scenario 'user sees name, description, location, and creator for the meetup' do
    visit '/meetups'
    click_link meetup.name

    expect(page).to have_content('Description: 4 on 4 street soccer')
    expect(page).to have_content('Location: Roller Rink in Jersey')
    expect(page).to have_content('Creator: Eric M.')
  end
end
