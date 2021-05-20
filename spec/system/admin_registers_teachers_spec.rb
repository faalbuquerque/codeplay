require 'rails_helper'

describe 'Admin registers teachers' do
  it 'from index page' do
    visit teachers_path

    expect(page).to have_link('Registrar um Professor',
                              href: new_teacher_path )
  end

  it 'successfully' do
    visit teachers_path
    click_on 'Registrar um Professor'

    fill_in 'Nome', with: 'Bob'
    fill_in 'E-mail', with: 'bob@email.com'
    fill_in 'Descrição', with: 'Eu sou o Bob'
    attach_file 'Foto de perfil', Rails.root.join('storage', 'bob.jpg')

    click_on 'Criar Professor'

    expect(current_path).to eq(teacher_path(Teacher.last))
    expect(page).to have_content('Bob')
    expect(page).to have_content('bob@email.com')
    expect(page).to have_content('Eu sou o Bob')
    expect(page).to have_css('img[src*="bob.jpg"]')
    expect(page).to have_link('Voltar')
  end

end