class User < BaseModel
  include Carbon::Emailable
  include Authentic::PasswordAuthenticatable

  table do
    column email : String
    column handle : String
    column encrypted_password : String
    column description : String
    column avatar : String
    column bot : Bool
    column active : Bool
    column data : JSON::Any
    column lastlogin_at : Time?
  end

  def emailable : Carbon::Address
    Carbon::Address.new(email)
  end
end
