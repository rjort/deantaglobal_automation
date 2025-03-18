# Usa uma imagem base do Ruby 2.7.8
FROM ruby:2.7.8

# Instala dependências do sistema, incluindo FreeTDS e ferramentas de compilação
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    freetds-dev \
    freetds-bin

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia o Gemfile e o Gemfile.lock para o container
COPY Gemfile Gemfile.lock ./

# Instala as gems
RUN bundle install

# Copia o restante do código da aplicação para o container
COPY . .

# Define o comando padrão para executar o Cucumber com os parâmetros desejados
CMD ["bundle", "exec", "cucumber", "-p", "api_serverest", "-t", "@ALL"]
