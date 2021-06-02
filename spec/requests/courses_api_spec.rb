require 'rails_helper'

describe 'Courses API' do
  context 'GET /api/v1/courses' do
    it 'should get courses' do

      teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                                bio: 'Eu sou o professor Bob')

      teacher.courses.create!(name: 'Ruby', description: 'Um curso de Ruby',
                              code: 'RUBYBASIC', price: 100,
                              enrollment_deadline: '22/12/2033')

      teacher.courses.create!(name: 'CSS', description: 'Um curso de CSS',
                              code: 'CSSBASIC', price: 10,
                              enrollment_deadline: '21/11/2055')

      get '/api/v1/courses'

      expect(response).to have_http_status(:ok)
      expect(parsed_body.count).to eq(Course.count)
      expect(parsed_body[0]['name']).to eq('Ruby')
      expect(parsed_body[1]['name']).to eq('CSS')
    end

    it 'return no courses' do
      get '/api/v1/courses'

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')

      expect(parsed_body).to be_empty
    end
  end

  context 'GET /api/v1/courses' do
    it 'should return a course' do

      teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                                bio: 'Eu sou o professor Bob')

      course = teacher.courses.create!(name: 'Ruby', description: 'Um curso de Ruby',
                                       code: 'RUBYBASIC', price: 100,
                                       enrollment_deadline: '22/12/2033')

      teacher.courses.create!(name: 'CSS', description: 'Um curso de CSS',
                              code: 'CSSBASIC', price: 10,
                              enrollment_deadline: '21/11/2055')

      get "/api/v1/courses/#{course.code}"

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['code']).to eq('RUBYBASIC')
      expect(response.body).not_to include('CSSBASIC')
    end

    it 'should not found course' do
      get '/api/v1/courses/asdfg12'

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'POST /api/v1/courses' do
    it 'should create a course' do
      teacher = Teacher.create!(name: 'Bob', email: 'bob@email.com',
                                bio: 'Eu sou o professor Bob')

      post '/api/v1/courses', params: { course: { name: 'Ruby',
                                                  code: 'RUBYBASIC',
                                                  price: 100,
                                                  teacher_id: teacher.id }
                                      }
      expect(response).to have_http_status(:created)
      expect(response.content_type).to include('application/json')
      expect(parsed_body['name']).to eq('Ruby')
      expect(parsed_body['code']).to eq('RUBYBASIC')
      expect(parsed_body['price']).to eq('100.0')
    end
  end
end
