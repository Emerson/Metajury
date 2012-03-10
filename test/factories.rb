FactoryGirl.define do

  sequence :unique_name do |n|
    "mr-firstname-#{n}"
  end

  sequence :unique_title do |n|
    "Awqesome Store - #{n}"
  end

  sequence :number do |n|
    "#{n}"
  end

end

FactoryGirl.define do

  factory :user do
    first_name 'John'
    last_name 'Smith'
    username "user#{FactoryGirl.generate(:number)}"
    email "clone#{FactoryGirl.generate(:unique_name)}@factory.com"
    password  'password'
  end

  factory :admin, :class => User do
    email "admin-#{FactoryGirl.generate(:unique_name)}@factory.com"
    password 'password'
    confirmed true
    token false
    username "Adminify#{FactoryGirl.generate(:number)}"
    first_name 'Mr. Admin'
    last_name 'Adminis'
    user_level 'admin'
    login_count 0
  end

  factory :super_admin, :class => User do
    email 'super-admin@factory.com'
    password 'password'
    confirmed true
    token false
    username "SuperAdminify#{FactoryGirl.generate(:number)}"
    first_name 'Mr. Admin'
    last_name 'Superious'
    user_level 'super-admin'
    login_count 0
  end

  factory :valid_user, :class => User do
    email "valid-user-#{FactoryGirl.generate(:unique_name)}@factory.com"
    password 'password'
    first_name 'Mr. Valid'
    last_name 'Validiously'
    username "Validious#{FactoryGirl.generate(:number)}"
    user_level 'user'
    login_count 0
    token false
    confirmed true
  end

  factory :unconfirmed_user, :class => User do
    email 'unconfirmed@factory.com'
    password 'password'
    first_name 'Mr. Unconfirmed'
    last_name "Unconfirmious"
    user_level 'user'
    username "unconfirmed#{FactoryGirl.generate(:number)}"
    login_count 0
    confirmed false
    token 'fh135aaa'
  end

  factory :vote, :class => Vote do
    item_id nil
    user_id nil
    group_id nil
    vote_type 'up'
  end

  factory :valid_submission, :class => Submission do
    user_id 1
    title FactoryGirl.generate(:unique_name)
    url 'http://www.emersonlackey.com'
    vote_tally 0
    description "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec bibendum, leo eget varius rhoncus, neque magna tempor ligula, ut posuere nibh felis sit amet metus. Nulla elementum cursus justo ac ullamcorper. Curabitur non enim eget sem pretium placerat. Cras viverra tempus erat, eget ornare augue tincidunt eu. Pellentesque eget arcu nisl, iaculis facilisis erat. Suspendisse ullamcorper urna sed turpis bibendum placerat. Aenean dapibus tincidunt orci quis viverra. Aenean faucibus enim vel metus laoreet ultrices."
  end

  factory :valid_comment, :class => Comment do
    content "This is an example comment"
    vote_tally 0
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