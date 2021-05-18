require 'rails_helper'

describe 'Admin edits courses' do
  it 'successfully' do
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2090')

    visit courses_path
    click_on 'Editar curso'

    fill_in 'Nome', with: 'RoR'
    fill_in 'Descrição', with: 'Curso de RoR'
    fill_in 'Código', with: 'ROR'
    fill_in 'Preço', with: '60'
    fill_in 'Data limite de matrícula', with: 10.days.from_now
    click_on 'Atualizar curso'

    expect(current_path).to eq(course_path(course))
    expect(page).to have_content('RoR')
    expect(page).to have_content('Curso de RoR')
    expect(page).to have_content('ROR')
    expect(page).to have_content('R$ 60,00')
    expect(page).to have_content((10.days.from_now).strftime('%d/%m/%Y'))
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033')

    visit edit_course_path(course)
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Preço', with: ''
    click_on 'Atualizar curso'

    expect(page).to have_content('não pode ficar em branco', count: 3)
  end

  it 'and code must be unique' do
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033')

    course_rails = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                  code: 'RAILSBASIC', price: 10,
                                  enrollment_deadline: '22/12/2033')

    visit edit_course_path(course_rails)
    fill_in 'Código', with: 'RUBYBASIC'
    click_on 'Atualizar curso'

    expect(page).to have_content('já está em uso')
  end
end
