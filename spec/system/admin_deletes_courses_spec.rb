require 'rails_helper'

describe 'Admin deletes courses' do
  it 'successfully' do
    Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                   code: 'RUBYBASIC', price: 10,
                   enrollment_deadline: '22/12/2033')

    js = Course.create!(name: 'JavaScript', description: 'Um curso de JavaScript',
                        code: 'JAVASCRIPT', price: 60,
                        enrollment_deadline: '01/02/2050')

    visit course_path(js)
    click_on 'Apagar Curso'

    expect(current_path).to eq(courses_path)
    expect(page).to have_content('Curso apagado com sucesso!')
    expect(page).to have_content('Ruby')
    expect(page).to have_content('Um curso de Ruby')
    expect(page).to have_content('R$ 10,00')
    expect(page).to_not have_content('JavaScript')
    expect(page).to_not have_content('Um curso de JavaScript')
    expect(page).to_not have_content('R$ 60,00')
  end

  it 'not exist' do
    js = Course.create!(name: 'JavaScript', description: 'Um curso de JavaScript',
                        code: 'JAVASCRIPT', price: 60,
                        enrollment_deadline: '01/02/2050')
    js.destroy!

    visit course_path(js)

    expect(page).to have_content('Oops, curso não disponivel')
  end

  it 'already been deleted' do
    js = Course.create!(name: 'JavaScript', description: 'Um curso de JavaScript',
                        code: 'JAVASCRIPT', price: 60,
                        enrollment_deadline: '01/02/2050')

    visit course_path(js)
    js.destroy
    click_on 'Apagar Curso'

    expect(current_path).to eq(courses_path)
    expect(page).to have_content('Oops, curso não disponivel')
  end
end
