require 'rails_helper'

describe 'Visitor search course' do
  it 'successfully' do
    teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                              bio: 'Eu sou o professor Bob')

    course_ruby = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                 code: 'RUBYBASIC', price: 200,
                                 enrollment_deadline: '22/12/2155',
                                 teacher: teacher)

    course_rails = Course.create!(name: 'Rails', description: 'Um curso de Rails',
                                  code: 'RAILSBASIC', price: 333,
                                  enrollment_deadline: '22/12/2033', 
                                  teacher: teacher)

    visit root_path

    fill_in 'Busca', with: 'Rails'
    click_on 'Pesquisar'

    expect(current_path).to eq('/search')
    expect(page).to  have_content('Rails')
    expect(page).to  have_content('R$ 333,00')
    expect(page).to_not  have_content('Ruby')
    expect(page).to_not  have_content('R$ 200,00')
  end

  it 'no results' do
    visit root_path

    fill_in 'Busca', with: 'Rails'
    click_on 'Pesquisar'

    expect(current_path).to eq('/search')
    expect(page).to  have_content('Nenhum resultado encontrado!')
  end
end
