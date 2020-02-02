class SignUpUser < User::SaveOperation
  param_key :user
  # Change password validations in src/operations/mixins/password_validations.cr
  include PasswordValidations

  permit_columns email
  permit_columns handle
  attribute password : String
  attribute password_confirmation : String

  before_save do
    validate_size_of handle, min: 3, max: 24
    validate_uniqueness_of email, query: UserQuery.new.email.lower
    validate_uniqueness_of handle, query: UserQuery.new.handle.lower
    validate_confirmation_of password, with: password_confirmation
    Authentic.copy_and_encrypt password, to: encrypted_password
  end
end
