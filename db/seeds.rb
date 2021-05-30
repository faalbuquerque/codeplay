teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                          bio: 'Eu sou o professor Bob')

course_ruby = teacher.courses.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                      code: 'RUBY-BASIC', price: 700,
                                      enrollment_deadline: '22/12/2033')

course_rails = teacher.courses.create!(name: 'Rails', description: 'Um curso de Rails',
                                     code: 'Rails-BASIC', price: 650,
                                     enrollment_deadline: '26/03/2074')

lesson_rspec = course_rails.lessons.create!(name:'Rspec com Ruby on Rails',
                                           duration: 50,
                                           content: 'Aula de testes com Rspec')

lesson_css = course_rails.lessons.create!(name:'Css com Rails', duration: 40,
                                        content: 'Aula de CSS com Rails')

lesson_tdd = course_ruby.lessons.create!(name:'TDD em Ruby on Rails', duration: 30,
                                        content: 'Aula de testes em RoR')

user = User.create!(email:'user@email.com', password: '123456',
                    password_confirmation: '123456')
