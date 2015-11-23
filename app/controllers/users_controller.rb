class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    
    if @user != current_user
      # ログイン中のユーザではないユーザ情報を表示しようとしているので
      # ホーム画面へリダイレクト
      flash[:danger] = "Invalid operation detected!"
      redirect_to root_url
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    if @user != current_user
      # ログイン中のユーザではないユーザ情報を編集しようとしているので
      # ホーム画面へリダイレクト
      flash[:danger] = "Invalid operation detected!"
      redirect_to root_url
    end
  end
  
  def update
    #binding.pry
    
    if @user != current_user
      # ログイン中のユーザではないユーザ情報を行進しようとしているので
      # ホーム画面へリダイレクト
      flash[:danger] = "Invalid operation detected!"
      redirect_to root_url
    end
    
    # 更新時のhas_secure_passwordは、
    # フォームから入力されたパスワードが空でも、エラーにならず、
    # DBのパスワードダイジェスト情報が空になることはない
    if @user.update(user_params)
      # 保存に成功した場合はユーザ画面へリダイレクト
      flash[:success] = "Success to edit profile!"
      redirect_to @user
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,
                                 :biography, :location, :birthday)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
