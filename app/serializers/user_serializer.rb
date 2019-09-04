class UserSerializer
  include FastJsonapi::ObjectSerializer
  set_type :user
  set_id :id
  attributes :first_name, :last_name, :phone_number, :email, :api_key
end
