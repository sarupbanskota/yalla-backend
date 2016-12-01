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
      Request.where user: @user
    end
  end

  power :activities do
    if @user.owner?
      Acitivity.all
    else
      Activity.where user: @user
    end
  end
end
