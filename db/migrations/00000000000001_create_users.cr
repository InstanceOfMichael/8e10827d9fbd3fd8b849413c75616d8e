class CreateUsers::V00000000000001 < Avram::Migrator::Migration::V1
  def migrate
    create table_for(User) do
      primary_key id : Int64
      add_timestamps
      add handle : String, unique: true
      add email : String, unique: true
      add encrypted_password : String
      add description : String
      add avatar : String
      add bot : Bool, default: false, index: true
      add active : Bool, default: false, index: true
      add data : JSON::Any
      add lastlogin_at : Time?
    end
  end

  def rollback
    drop table_for(User)
  end
end
