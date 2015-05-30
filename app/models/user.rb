class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  # This is added by default when rails generates "password:digest" within a scaffold. This tells rails to validate
  # that the password and password_confirmation match. By default, both of these form fields were created during
  # the scaffolding process in users/_form.html.erb.
  has_secure_password
end
