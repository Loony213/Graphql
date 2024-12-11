# hola_mundo_graphql.rb
require 'sinatra'
require 'graphql'

# Define un tipo básico llamado Query
class QueryType < GraphQL::Schema::Object
  description "La raíz de todas las consultas"

  field :hello, String, null: false, description: "Retorna un saludo" do
    argument :name, String, required: false, description: "Tu nombre"
  end

  def hello(name: nil)
    name ? "¡Hola, #{name}!" : "¡Hola, Mundo!"
  end
end

# Define el esquema
class HolaMundoSchema < GraphQL::Schema
  query(QueryType)
end

# Configura un servidor básico con Sinatra
class App < Sinatra::Base
  post "/graphql" do
    request_payload = JSON.parse(request.body.read)
    result = HolaMundoSchema.execute(
      request_payload["query"],
      variables: request_payload["variables"],
      context: {}
    )
    content_type :json
    result.to_json
  end

  get "/" do
    "Bienvenido a mi servidor GraphQL. Usa /graphql para enviar consultas."
  end
end

# Ejecuta la aplicación
App.run! if __FILE__ == $0
