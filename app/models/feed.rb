class Feed < ActiveRecord::Base


  def self.new_user(user)
    feeditem = self.create({
      :user_id     => user.id,
      :admin       => true,
      :public_feed => false,
      :feed_type   => 'user_registration',
      :data        => {:email => user.email, :first_name => user.first_name}.to_json
    })
  end


  def self.confirm_user(user)
    feeditem = self.create({
      :user_id     => user.id,
      :admin       => true,
      :public_feed => false,
      :feed_type   => 'user_confirmation',
      :data        => {:email => user.email, :first_name => user.first_name}.to_json
    })
  end


  def self.login_user(user)
    feeditem = self.create({
      :user_id     => user.id,
      :admin       => true,
      :public_feed => false,
      :feed_type   => 'user_login',
      :data        => {:email => user.email, :first_name => user.first_name}.to_json
    })
  end


  def self.logout_user(user)
    feeditem = self.create({
      :user_id     => user.id,
      :admin       => true,
      :public_feed => false,
      :feed_type   => 'user_logout',
      :data        => {:email => user.email, :first_name => user.first_name}.to_json
    })
  end


end