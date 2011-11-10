FactoryGirl.define do

  factory :user do
    email 'clone@factory.com'
    password  'password'
    first_name 'Mr. Clone'
  end

  factory :admin, :class => User do
    email 'admin@factory.com'
    password 'password'
    confirmed true
    token false
    first_name 'Mr. Admin'
    user_level 'admin'
    login_count 0
  end

  factory :valid_user, :class => User do
    email 'valid-user@factory.com'
    password 'password'
    first_name 'Mr. Valid'
    user_level 'user'
    login_count 0
    confirmed true
  end
  # This will use the User class (Admin would have been guessed)
  # factory :admin, :class => User do
  #   first_name 'Admin'
  #   last_name  'User'
  #   admin true
  # end

  # The same, but using a string instead of class constant
  # factory :admin, :class => 'user' do
  #   first_name 'Admin'
  #   last_name  'User'
  #   admin true
  # end

end