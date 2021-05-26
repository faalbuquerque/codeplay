require 'rails_helper'

describe 'Admin edits lessons' do
  it 'successfully' do
    teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                              bio: 'Eu sou o professor Bob')

    course_ruby = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                 code: 'RUBYBASIC', price: 10,
                                 enrollment_deadline: '22/12/2033',
                                 teacher: teacher)

    lesson_rspec = Lesson.create!(name:'Rspec com Ruby on Rails', duration: 10,
                                  content: 'Aula de testes com Rspec',
                                  course: course_ruby)

    visit course_path(course_ruby)
    click_on 'Editar Aula'

    fill_in 'Nome', with: 'Nested routes'
    fill_in 'Duração', with: '20'
    fill_in 'Conteúdo', with: 'Aula de rotas aninhadas'
    click_on 'Atualizar Aula'

    expect(page).to have_text('Nested routes')
    expect(page).to have_text('20 minutos')
    expect(page).to have_text('Aula atualizada com sucesso!')
  end

  it 'and attributes cannot be blank' do
    teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                              bio: 'Eu sou o professor Bob')

    course_ruby = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                 code: 'RUBYBASIC', price: 10,
                                 enrollment_deadline: '22/12/2033',
                                 teacher: teacher)

    lesson_rspec = Lesson.create!(name:'Rspec com Ruby on Rails', duration: 10,
                                  content: 'Aula de testes com Rspec',
                                  course: course_ruby)

    visit course_path(course_ruby)
    click_on 'Editar Aula'

    fill_in 'Nome', with: ''
    fill_in 'Duração', with: ''
    fill_in 'Conteúdo', with: ''
    click_on 'Atualizar Aula'

    expect(page).to have_text('Nome não pode ficar em branco')
    expect(page).to have_text('Duração não pode ficar em branco')
    expect(page).to have_text('Conteúdo não pode ficar em branco')
  end
end
