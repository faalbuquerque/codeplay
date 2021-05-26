require 'rails_helper'

describe 'Admin view lessons' do
  it 'of a course' do
    teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                              bio: 'Eu sou o professor Bob')

    course_ruby = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                 code: 'RUBYBASIC', price: 10,
                                 enrollment_deadline: '22/12/2033', 
                                 teacher: teacher)

    lesson_rspec = Lesson.create!(name:'Rspec com Ruby on Rails', duration: 10,
                                  content: 'Aula de testes com Rspec',
                                  course: course_ruby)

    lesson_obj = Lesson.create!(name:'Objetos em Ruby', duration: 30,
                                content: 'Aula de objetos em Ruby',
                                course: course_ruby)

    course_TDD = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                code: 'TDDBASIC', price: 10,

                                enrollment_deadline: '22/12/2033', teacher: teacher)
    lesson_TDD = Lesson.create!(name:'Aula de TDD em RoR', duration: 50,
                                content: 'Aula de objetos em Ruby', course: course_TDD)

    visit course_path(course_ruby)

    expect(page).to  have_link('Rspec com Ruby on Rails')
    expect(page).to  have_content('10 minutos')
    expect(page).to  have_link('Objetos em Ruby')
    expect(page).to  have_content('30 minutos')
    expect(page).to_not  have_text('Aula de TDD em RoR')
    expect(page).to_not  have_text('50 minutos')
  end

  it 'and view details' do
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
    click_on(lesson_obj.name)

    expect(page).to have_link('Voltar')
    expect(page).to  have_content('Objetos em Ruby')
    expect(page).to  have_content('30 minutos')
    expect(page).to  have_content('Aula de objetos em Ruby')
  end
end
