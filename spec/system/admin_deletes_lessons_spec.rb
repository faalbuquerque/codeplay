require 'rails_helper'

describe 'Admin deletes lessons' do
  it 'successfully' do
    teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                              bio: 'Eu sou o professor Bob')

    course_ruby = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                 code: 'RUBYBASIC', price: 10,
                                 enrollment_deadline: '22/12/2033',
                                 teacher: teacher)

    lesson_obj = Lesson.create!(name:'Objetos em Ruby', duration: 30,
                                content: 'Aula de objetos em Ruby',
                                course: course_ruby)

    visit course_path(course_ruby)
    click_on 'Apagar Aula'

    expect(page).to have_text('Aula apagada com sucesso!')
    expect(page).to_not have_text('Objetos em Ruby')
    expect(page).to_not have_text('30 minutos')

  end

  it 'and no lessons' do
    teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                              bio: 'Eu sou o professor Bob')

    course_ruby = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                 code: 'RUBYBASIC', price: 10,
                                 enrollment_deadline: '22/12/2033',
                                 teacher: teacher)

    visit course_path(course_ruby)

    expect(page).to have_content('Sem aulas disponiveis!')
  end
end
