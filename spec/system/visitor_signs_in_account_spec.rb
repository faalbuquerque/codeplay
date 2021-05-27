require 'rails_helper'

describe 'Visitor signs in account' do
  it 'successfully' do
    User.create!(email:'bob@email.com', password: '123456',
                 password_confirmation: '123456')

    visit root_path
    click_on 'Entrar na conta'

    fill_in 'Email', with: 'bob@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'

    expect(page).to have_text('Login efetuado com sucesso')
    expect(page).to have_text('bob@email.com')
    expect(current_path).to eq(root_path)
    expect(page).to have_link('Sair')
    expect(page).to_not have_text('Entrar na conta')
  end

  it 'and attributes cannot be blank' do
    visit new_user_session_path

    fill_in 'Email', with: ''
    fill_in 'Senha', with: ''
    click_on 'Entrar'

    expect(page).to have_text('Email ou senha inválida')
    expect(current_path).to eq(user_session_path)
  end

  it 'and password not match' do
    User.create!(email:'bob@email.com', password: '123456',
                 password_confirmation: '123456')

    visit visit new_user_session_path

    fill_in 'Email', with: 'bob@email.com'
    fill_in 'Senha', with: '65656565'
    click_on 'Entrar'

    expect(page).to have_text('Email ou senha inválida')
    expect(current_path).to eq(user_session_path)
  end

  it 'and sign out' do
    user = User.create!(email:'bob@email.com', password: '123456',
                        password_confirmation: '123456')

    login_as user, scope: :user
    visit root_path
    click_on 'Sair'

    expect(page).to have_text('Saiu com sucesso')
    expect(current_path).to eq(root_path)
    expect(page).to have_link('Registrar-me')
    expect(page).to have_link('Entrar na conta')
    expect(page).to_not have_text('bob@email.com')
    expect(page).to_not have_link('Sair')
  end
end
