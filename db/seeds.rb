puts
puts "Criando Seeds"
puts

teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                          bio: 'Eu sou o professor Bob')
puts "Professor #{teacher.name} criado com sucesso!"

course_ruby = teacher.courses.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                      code: 'RUBY-BASIC', price: 700,
                                      enrollment_deadline: '22/12/2033')
puts "Curso #{course_ruby.name} criado com sucesso!"

course_rails = teacher.courses.create!(name: 'Rails', description: 'Um curso de Rails',
                                     code: 'Rails-BASIC', price: 650,
                                     enrollment_deadline: '26/03/2074')
puts "Curso #{course_rails.name} criado com sucesso!"

lesson_rspec = course_rails.lessons.create!(name:'Rspec com Ruby on Rails',
                                           duration: 50,
                                           content: 'Aula de testes com Rspec')
puts "Aula #{lesson_rspec.name} criado com sucesso!"

lesson_css = course_rails.lessons.create!(name:'CSS com Rails', duration: 40,
                                        content: 'Aula de CSS com Rails')
puts "Aula #{lesson_css.name} criado com sucesso!"

lesson_tdd = course_ruby.lessons.create!(name:'TDD em Ruby on Rails', duration: 30,
                                        content: 'Aula de testes em RoR')
puts "Aula #{lesson_tdd.name} criado com sucesso!"

unless Rails.env.production? 
  user = User.create!(email:'user@tester.com', password: '123456',
                      password_confirmation: '123456')
  puts "Usuário de teste #{user.email}, senha: 123456, criado com sucesso!"

else
  puts 'ATENÇÃO! Usuário não criado, rodando em produção'
end
