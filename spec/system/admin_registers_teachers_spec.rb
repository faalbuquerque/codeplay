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
    attach_file 'Foto de perfil', Rails.root.join('spec/fixtures/bob.jpg')

    click_on 'Criar Professor'

    expect(current_path).to eq(teacher_path(Teacher.last))
    expect(page).to have_content('Bob')
    expect(page).to have_content('bob@email.com')
    expect(page).to have_content('Eu sou o Bob')
    expect(page).to have_css('img[src*="bob.jpg"]')
    expect(page).to have_link('Voltar')
  end

  it 'and attributes cannot be blank' do
    visit new_teacher_path
    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Descrição', with: 'Eu sou o Bob'
    attach_file 'Foto de perfil', Rails.root.join('spec/fixtures/bob.jpg')

    click_on 'Criar Professor'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('E-mail não pode ficar em branco')
  end

  it 'and email must be unique' do
    teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                              bio: 'Eu sou o professor Bob' )

    visit new_teacher_path

    fill_in 'Nome', with: 'Bobzinho'
    fill_in 'E-mail', with: 'bob@email.com'

    click_on 'Criar Professor'

    expect(page).to have_content('E-mail já está em uso')
  end
end
