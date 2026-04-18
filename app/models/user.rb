class User < ApplicationRecord
  has_secure_password

  has_many :tasks, dependent: :destroy

  before_save { self.email = email.downcase }

  validates :name, presence: { message: 'Please enter your name' }
  validates :email, presence: { message: 'Please enter your e-mail address' },
                    uniqueness: { case_sensitive: false, message: 'Your email address is already in use' }
  validates :password, presence: { message: 'Enter your password' },
                       length: { minimum: 6, message: 'Please enter the password with at least 6 characters' },
                       allow_nil: true

  validate :cannot_delete_last_admin, on: :destroy_callback
  before_destroy :check_last_admin
  before_update :check_last_admin_demotion

  private

  def check_last_admin
    if admin? && User.where(admin: true).count == 1
      errors.add(:base, 'Cannot delete because there are zero administrators')
      throw :abort
    end
  end

  def check_last_admin_demotion
    if admin_changed? && !admin && User.where(admin: true).count == 1
      errors.add(:base, 'Cannot change privileges because there are zero administrators')
      throw :abort
    end
  end

  def cannot_delete_last_admin
  end
end
