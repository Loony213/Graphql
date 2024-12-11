# Usa una imagen base de Ruby
FROM ruby:3.3

# Configura el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia tu Gemfile y Gemfile.lock (si existe) al contenedor
COPY Gemfile ./

# Instala las dependencias
RUN bundle install

# Copia el resto de los archivos del proyecto
COPY . .

# Expon el puerto en el que correrá Sinatra
EXPOSE 4567

# Comando para iniciar la aplicación
CMD ["ruby", "hola_mundo_graphql.rb"]
