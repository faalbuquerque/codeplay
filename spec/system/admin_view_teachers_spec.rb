require 'rails_helper'

describe 'Admin view teachers' do
  it 'successfully' do
    Teacher.create!(name: 'Bob', email: 'bob@email.com',
                    bio: 'Eu sou o professor Bob' )

    Teacher.create!(name: 'Bart', email: 'bart@email.com',
                    bio: 'Eu sou o professor Bart' )

    visit root_path
    click_on 'Professores'

    expect(current_path).to eq(teachers_path)
    expect(page).to have_link('Voltar')
    expect(page).to have_content('Bob')
    expect(page).to have_content('bob@email.com')
    expect(page).to have_content('Bart')
    expect(page).to have_content('bart@email.com')
  end

  it 'and view details' do
    teacher = Teacher.create!(name: 'Bart', email: 'bart@email.com',
                              bio: 'Eu sou o professor Bart')

    visit root_path
    click_on 'Professores'
    click_on 'Bart'

    expect(current_path).to eq teacher_path(teacher)
    expect(page).to have_link('Voltar')
    expect(page).to have_content('Bart')
    expect(page).to have_content('bart@email.com')
    expect(page).to have_content('Eu sou o professor Bart')
  end

  it 'and no registered teachers' do
    visit teachers_path

    expect(page).to have_content('Nenhum professor cadastrado')
  end
end
