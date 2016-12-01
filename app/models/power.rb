class Power
  include Consul::Power

  def initialize(user)
    @user = user
  end

  power :users do
    User.all
  end

  power :requests do
    if @user.owner?
      Request.all
    else
      Request.where user_id: @user.id
    end
  end
end
