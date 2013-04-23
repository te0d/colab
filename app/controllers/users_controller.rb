class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :require_admin_priv, :except => [:edit, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @permissions = @user.permissions.includes(:group)
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    generated_password = Devise.friendly_token.first(8)
    @user.password = generated_password
    @user.password_confirmation = generated_password
    
    Pony.mail({
      :to => @user.email,
      :subject => 'Chi Phi CoLab Password',
      :body => generated_password,
      :via => :smtp,
      :via_options => {
        :address => 'smtp.gmail.com',
        :port => '587',
        :enable_starttls_auto => true,
        :user_name => ENV['CHI_PHI_COLAB_EMAIL_ADDR'],
        :password => ENV['CHI_PHI_COLAB_EMAIL_PASS'],
        :authentication => :plain,
        :domain => 'localhost.localdomain'
      }
    })

    
    if @user.save
      redirect_to users_path, :notice => "User created."
    else
      redirect_to users_path, :notice => "User could not be created."
    end
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_with_password(params[:user])
      redirect_to root_url, :notice => 'Password successfully updated.'
    else
      redirect_to root_url, :notice => 'Password update failed.'
    end
  end

  def destroy
  end

  private

  def require_admin_priv
    unless current_user.has_permission(1, 5)
      flash[:error] = "You must be an administrator to do this."
      redirect_to groups_url, :notice => "You must be an administrator to do this."
    end
  end
end
