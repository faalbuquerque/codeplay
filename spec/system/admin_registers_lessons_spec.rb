require 'rails_helper'

describe 'Admin registers lessons' do
  it 'successfully' do
    teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                              bio: 'Eu sou o professor Bob')

    course_ruby = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                 code: 'RUBYBASIC', price: 10,
                                 enrollment_deadline: '22/12/2033', 
                                 teacher: teacher)

    visit course_path(course_ruby)
    click_on 'Adicionar aula'

    fill_in 'Nome', with: 'Nested routes'
    fill_in 'Duração', with: '20'
    fill_in 'Conteúdo', with: 'Aula de rotas aninhadas'
    click_on 'Criar Aula'

    expect(page).to have_text('Nested routes')
    expect(page).to have_text('20 minutos')
    expect(page).to have_text('Aula adicionada com sucesso!')
    expect(current_path).to eq(course_path(course_ruby))
  end

  it 'and attributes cannot be blank' do
    teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                              bio: 'Eu sou o professor Bob')

    course_ruby = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                 code: 'RUBYBASIC', price: 10,
                                 enrollment_deadline: '22/12/2033', 
                                 teacher: teacher)

    visit new_course_lesson_path(course_ruby)

    fill_in 'Nome', with: ''
    fill_in 'Duração', with: ''
    fill_in 'Conteúdo', with: ''
    click_on 'Criar Aula'

    expect(page).to have_text('Nome não pode ficar em branco')
    expect(page).to have_text('Duração não pode ficar em branco')
    expect(page).to have_text('Conteúdo não pode ficar em branco')
    expect(current_path).to eq(course_lessons_path(course_ruby))
  end
end
