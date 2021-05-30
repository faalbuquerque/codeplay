require 'rails_helper'

describe 'User purchases course' do
  it 'successfully' do
    teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                              bio: 'Eu sou o professor Bob')

    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', teacher: teacher)

    user = User.create!(email:'user@email.com', password: '123456',
                        password_confirmation: '123456')

    lesson_rspec = course.lessons.create!(name:'Rspec com Ruby on Rails', 
                                          duration: 10,
                                          content: 'Aula de testes com Rspec')

    lesson_css = course.lessons.create!(name:'Css com Ruby', duration: 20,
                                        content: 'Aula de ruby com CSS')

    login_as user, scope: :user

    visit courses_path

    click_on 'Comprar'

    expect(page).to have_content('Aula: Rspec com Ruby on Rails')
    expect(page).to have_content('10 minutos')
    expect(page).to have_content('Aula de testes com Rspec')
    expect(page).to have_content('Css com Ruby')
    expect(page).to_not have_content('20 minutos')
    expect(page).to_not have_content('Aula de ruby com CSS')
    expect(current_path).to eq(course_lesson_path(course, lesson_rspec))
  end
end
