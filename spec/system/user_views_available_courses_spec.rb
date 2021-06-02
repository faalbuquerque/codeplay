require 'rails_helper'

describe 'User views available courses' do
  it 'successfully, purchase available' do
    teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                              bio: 'Eu sou o professor Bob')
    course_available = teacher.courses.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                               code: 'RUBYBASIC', price: 100,
                                               enrollment_deadline: 1.month.from_now)
    course_unavailable = teacher.courses.create!(name: 'CSS', description: 'Um curso de CSS',
                                                code: 'CSSBASIC', price: 50,
                                                enrollment_deadline: 1.day.ago)

    visit root_path

    expect(page).to  have_content('Ruby')
    expect(page).to_not  have_content('CSS')
  end

  it 'and view purchase link' do
    teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                              bio: 'Eu sou o professor Bob')
    course = teacher.courses.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033')
    user = User.create!(email:'user@email.com', password: '123456',
                        password_confirmation: '123456')

    login_as user, scope: :user
    visit root_path
    click_on(course.name)

    expect(page).to have_content('Comprar curso')
  end

  it 'and must be signed in to purchase' do
    teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                              bio: 'Eu sou o professor Bob')
    course = teacher.courses.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033')
    user = User.create!(email:'user@email.com', password: '123456',
                        password_confirmation: '123456')

    visit root_path
    click_on(course.name)

    expect(page).to_not have_content('Comprar curso')
    expect(page).to have_content('Necessário estar logado para comprar curso!')
  end

  xit 'and not view purchase link if deadline is over' do
  end

  it 'successfully, purchase course' do
    teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                              bio: 'Eu sou o professor Bob')
    course_ruby = teacher.courses.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                          code: 'RUBYBASIC', price: 100,
                                          enrollment_deadline: 1.month.from_now)

    course_html = teacher.courses.create!(name: 'HTML', description: 'Um curso de HTML',
                                          code: 'HTMLBASIC', price: 30,
                                          enrollment_deadline: 1.month.from_now)
    user = User.create!(email:'user@email.com', password: '123456',
                        password_confirmation: '123456')

    login_as user, scope: :user
    visit root_path
    click_on(course_ruby.name)
    click_on('Comprar curso')

    expect(page).to have_content('Curso comprado com sucesso!')
    expect(current_path).to eq(my_courses_path)
    expect(page).to have_content('Ruby')
    expect(page).to_not have_content('Curso comprado com sucesso!')

    # expect(page).to have_content('Aula: Rspec com Ruby on Rails')
    # expect(page).to have_content('10 minutos')
    # expect(page).to have_content('Aula de testes com Rspec')
    # expect(page).to have_content('Css com Ruby')
    # expect(page).to_not have_content('20 minutos')
    # expect(page).to_not have_content('Aula de ruby com CSS')
    # expect(current_path).to eq(course_lesson_path(course, lesson_rspec))
  end
end