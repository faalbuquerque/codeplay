module CoursesApiSpecHelpers

  include Warden::Test::Helpers
  def parsed_body
    JSON.parse(response.body)
  end
end
