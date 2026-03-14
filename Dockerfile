# Ruby 버전을 3.1로 올려서 최신 라이브러리들과의 충돌을 피합니다.
FROM ruby:3.1

# 빌드 도구 설치
RUN apt-get update -qq && apt-get install -y build-essential

WORKDIR /app

# Bundler 설치
RUN gem install bundler -v 2.4.22

# 의존성 버전을 고정하기 위해 lock 파일까지 함께 복사
COPY Gemfile Gemfile.lock ./

# lock 파일 기준으로 gem 설치
RUN bundle install

COPY . .

EXPOSE 4000
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--force_polling"]
