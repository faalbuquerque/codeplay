require 'rails_helper'

describe 'Visitor creates account' do
  it 'with email and password' do
    visit root_path
    click_on 'Registrar-me'

    fill_in 'Email', with: 'bob@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmação de senha', with: '123456'
    click_on 'Criar conta'

    expect(page).to have_text('Login efetuado com sucesso')
    expect(page).to have_text('bob@email.com')
    expect(current_path).to eq(root_path)
    expect(page).to have_link('Sair')
    expect(page).to_not have_text('Registrar-me')
  end

  it 'and attributes cannot be blank' do
    visit new_user_registration_path

    fill_in 'Email', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirmação de senha', with: ''
    click_on 'Criar conta'

    expect(page).to have_text('Email não pode ficar em branco')
    expect(page).to have_text('Senha não pode ficar em branco')
    expect(current_path).to eq(user_registration_path)
  end

  it 'and password not match' do
    visit new_user_registration_path

    fill_in 'Email', with: 'bob@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmação de senha', with: '654321'
    click_on 'Criar conta'

    expect(page).to have_text('Confirmação de senha não é igual a Senha')
    expect(current_path).to eq(user_registration_path)
  end

  it 'and email not unique' do
    User.create!(email:'bob@email.com', password: '123456',
                 password_confirmation: '123456')

    visit new_user_registration_path

    fill_in 'Email', with: 'bob@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmação de senha', with: '123456'
    click_on 'Criar conta'

    expect(page).to have_text('Email já está em uso')
    expect(current_path).to eq(user_registration_path)
  end
end
