require 'rails_helper'

describe 'Admin deletes teachers' do
  it 'successfully' do
    teacher_bob = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                              bio: 'Eu sou o professor Bob')
    teacher_ana = Teacher.create!(name: 'Ana', email: 'ana@email.com',
                                bio: 'Eu sou a professora Ana')

    visit teachers_path

    within("p#del-#{teacher_bob.id}") do
      click_on 'Excluir Professor'
    end

    expect(current_path).to eq(teachers_path)
    expect(page).to have_content('Professor excluido com sucesso!')
    expect(page).to have_content('Ana')
    expect(page).to have_content('ana@email.com')
    expect(page).to_not have_content('Bob')
    expect(page).to_not have_content('bob@email.com')
  end

  it 'already been deleted' do
    teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                              bio: 'Eu sou o professor Bob')

    teacher.destroy

    visit teacher_path(teacher)

    expect(current_path).to eq(teacher_path(teacher))
    expect(page).to have_content('Não foi possivel encontrar professor!')
  end
end
