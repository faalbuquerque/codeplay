# Codplay

Plataforma de cursos para estudos como parte do treinamento da Campus Code(TreinaDev)


## Tecnologias utilizadas:

➡️ Ruby on Rails

➡️ RSPEC

➡️ Devise


## Executando o projeto:

No terminal, clone o projeto:
```
git clone https://github.com/faalbuquerque/codeplay.git
```

Entre na pasta do projeto:
```
cd codeplay
```

Execute os comandos:
```
bundle install && yarn install && rails db:migrate
```

Rode o servidor do Projeto:
```
rails s
```

Visualize no navegador:
```
127.0.0.1:3000
```

## Dados para testes:

```
rails db:seed

*Informações de acesso serão impressas no terminal
```
<br>

## API de cursos:

### Para listar todos os Cursos utilize:
```
GET  http://127.0.0.1:3000/api/v1/courses/
```
### Output
```json
[
  {
    "id": 1,
    "name": "Ruby",
    "description": "Um curso de Ruby",
    "code": "RUBY-BASIC",
    "price": "700.0",
    "enrollment_deadline": "2033-12-22",
    "teacher": {
      "id": 1,
      "name": "Bob",
      "email": "bob@email.com",
      "bio": "Eu sou o professor Bob",
      "created_at": "2021-06-02T23:06:44.352Z",
      "updated_at": "2021-06-02T23:06:44.352Z"
    }
  },
  {
    "id": 2,
    "name": "Rails",
    "description": "Um curso de Rails",
    "code": "Rails-BASIC",
    "price": "650.0",
    "enrollment_deadline": "2074-03-26",
    "teacher": {
      "id": 1,
      "name": "Bob",
      "email": "bob@email.com",
      "bio": "Eu sou o professor Bob",
      "created_at": "2021-06-02T23:06:44.352Z",
      "updated_at": "2021-06-02T23:06:44.352Z"
    }
  }
]

```
## Para mostrar um Curso
```
GET http://127.0.0.1:3000/api/v1/courses/#{code: params[:code]}
```

### Output
```json
{
  "id": 1,
  "name": "Ruby",
  "description": "Um curso de Ruby",
  "code": "RUBY-BASIC",
  "price": "700.0",
  "enrollment_deadline": "2033-12-22",
  "created_at": "2021-06-02T23:06:44.400Z",
  "updated_at": "2021-06-02T23:06:44.400Z",
  "teacher_id": 1
}
```

## Para criar um Curso
```
POST http://127.0.0.1:3000/api/v1/courses/
```

### Input
```json
{ 
  "course": { "name": "Ruby",
              "description": "Um curso de Ruby",
              "code": "RUBYBASIC",
              "price": 100,
              "enrollment_deadline": "2033-12-22",
              "teacher_id": 1 }
}
```

### Output success
```json
{
  "id": 1,
  "name": "Ruby",
  "description": "Um curso de Ruby",
  "code": "RUBY-BASIC",
  "price": "700.0",
  "enrollment_deadline": "2033-12-22",
  "teacher": {
    "id": 1,
    "name": "Bob",
    "email": "bob@email.com",
    "bio": "Eu sou o professor Bob",
    "created_at": "2021-06-02T23:06:44.352Z",
    "updated_at": "2021-06-02T23:06:44.352Z"
  }
```
