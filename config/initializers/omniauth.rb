Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['70a7f8948025c1d62d85'], ENV['9dc9187185da844123d6a1fe62d853c2a1cf8b9d']
 end