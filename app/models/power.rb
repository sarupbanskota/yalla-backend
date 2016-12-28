class Power
  include Consul::Power

  def initialize(user)
    @user = user
  end

  power :users do
    if @user.owner?
      User.all
    else
      User.where id: @user.id
    end
  end

  power :patchable_users do
    if @user.owner?
      User.all
    else
      User.where user: @user
    end
  end

  power :requests do
    if @user.owner?
      Request.all
    else
      Request.where user: @user
    end
  end

  power :patchable_requests do
    if @user.owner?
      Request.all
    else
      nil
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
