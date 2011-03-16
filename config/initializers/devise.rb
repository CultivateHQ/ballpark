# Use this hook to configure devise mailer, warden hooks and so forth. The first
# four configuration values can also be set straight in your models.
Devise.setup do |config|
  config.mailer_sender = "no-reply@edgecase.com"

  require 'devise/orm/mongoid'

  config.stretches = 10
  config.encryptor = :bcrypt

  config.pepper = "2ca0c1387612b931e3c72560f73e7d542cb8a20c71619fb07b1680bfd0b4d26e3d9f73443425a75aa19043190256e8d7d6e60d21d481b18a14ed86fbec405a5b"

end
