require 'rails_helper'

describe 'Visitor visit Homepage' do

  it 'successfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'Codeplay')
    expect(page).to have_css('h3', text: 'Boas vindas ao sistema de gestao de cursos e aulas')
  end
end
