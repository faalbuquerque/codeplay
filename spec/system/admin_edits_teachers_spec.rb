require 'rails_helper'

describe 'Admin edits teachers' do
  it 'successfully' do
    teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                              bio: 'Eu sou o professor Bob',
                              profile_picture: fixture_file_upload(Rails.root.join('spec/fixtures/bob.jpg')))

    visit teachers_path

    find("a[href='#{edit_teacher_path(teacher)}']").click

    fill_in 'Nome', with: 'Mary'
    fill_in 'E-mail', with: 'mary@email.com'
    fill_in 'Descrição', with: 'Eu sou a Mary'
    attach_file 'Foto de perfil', Rails.root.join('spec/fixtures/lisa.jpg')

    click_on 'Atualizar Professor'

    expect(page).to  have_content('Mary')
    expect(page).to  have_content('mary@email.com')
    expect(page).to  have_content('Eu sou a Mary')
    expect(page).to  have_css('img[src*="lisa.jpg"]')
  end

  it 'and attributes cannot be blank' do

    teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                              bio: 'Eu sou o professor Bob',
                              profile_picture: fixture_file_upload(Rails.root.join('spec/fixtures/bob.jpg')))

    visit edit_teacher_path(teacher)

    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Descrição', with: 'Eu sou o Bob'
    attach_file 'Foto de perfil', Rails.root.join('spec/fixtures/bob.jpg')

    click_on 'Atualizar Professor'

    expect(page).to have_content('Nome não pode ficar em branco')
    expect(page).to have_content('E-mail não pode ficar em branco')
  end

  it 'and email must be unique' do
    teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                              bio: 'Eu sou o professor Bob',
                              profile_picture: fixture_file_upload(Rails.root.join('spec/fixtures/bob.jpg')))

    teacher_m = Teacher.create!(name: 'Mary', email: 'mary@email.com',
                                bio: 'Eu sou a professor Mary',
                                profile_picture: fixture_file_upload(Rails.root.join('spec/fixtures/lisa.jpg')))

    visit edit_teacher_path(teacher_m)

    fill_in 'E-mail', with: 'bob@email.com'
    click_on 'Atualizar Professor'

    expect(page).to have_content('já está em uso')
  end
end
