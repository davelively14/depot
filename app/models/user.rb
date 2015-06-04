class User < ActiveRecord::Base
  after_destroy :ensure_an_admin_remains
  validates :name, presence: true, uniqueness: true

  # This is added by default when rails generates "password:digest" within a scaffold. This tells rails to validate
  # that the password and password_confirmation match. By default, both of these form fields were created during
  # the scaffolding process in users/_form.html.erb.
  has_secure_password

  # Prevents deletion of the last remaining admin, which is necessary to create other admins. Because this is raised
  # inside a transaction, it causes an automatic rollback. By raising the exception if the users table is empty
  # after the deletion, we undo the delete and restore the last user.
  private

    def ensure_an_admin_remains
      if User.count.zero?
        raise "Can't delete last user"
      end
    end
end
