class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index]
  before_filter :correct_user, only: [:edit, :update]

  def show
  	@user = User.find(params[:id])
    @rank_list = User.find(:all, order: :score).reverse
    @top5 = @rank_list.slice(0,5)
    @pos = @rank_list.rindex(@user) + 1
    @areas = @user.areas
  end

  def new
  	@user = User.new
    (Area.all - @user.areas).each do |area|
    @user.area_users.build( area_id: area.id )
    end
    @user.area_users.sort_by! { |x| x.area.name }
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:alert] = "Se ha enviado un mail para confirmar tu direccion."
      UserMailer.registration_confirmation(@user).deliver
      redirect_to root_path
    else
      @user.area_users=[]
      (Area.all - @user.areas).each do |area|
      @user.area_users.build( area_id: area.id )
      end
      @user.area_users.sort_by! { |x| x.area.name }
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    (Area.all - @user.areas).each do |area|
      @user.area_users.build( area_id: area.id )
    end
    @user.area_users.sort_by! { |x| x.area.name }
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Datos Cambiados."
      sign_in @user
      redirect_to @user
    else
      @user.area_users=[]
      (Area.all - @user.areas).each do |area|
      @user.area_users.build( area_id: area.id )
      end
      @user.area_users.sort_by! { |x| x.area.name }      
      render 'edit'
    end
  end

  def index
    @users = User.find_all_by_confirmed(1, order: :score).reverse
  end

  def top5
    @users = User.find(:all, order: :name, limit: 5)
  end

  def destroy
    @user = User.find(params[:id])
    @user.update_attribute(:confirmed, 0)
    flash[:success] = "Usuario Eliminado"
    redirect_to root_path
  end

  def premiar
    @score = self.score+10
    self.update_attribute(:score, @score) 
  end

  def buy_sml
    @user = current_user
    @score = @user.score+75
    @user.update_attribute(:score, @score) 
    sign_in @user
    redirect_to @user
  end

  def buy_med
    @user = current_user
    @score = @user.score+150
    @user.update_attribute(:score, @score) 
    sign_in @user
    redirect_to @user
  end

  def buy_lrg
    @user = current_user
    @score = @user.score+300
    @user.update_attribute(:score, @score) 
    sign_in @user
    redirect_to @user
  end

  def confirm_reg
    @user = User.find(params[:id])
    @confirm = 1
    @user.update_attribute(:confirmed, @confirm) 
    sign_in @user
    flash[:success] = "Usuario confirmado!"
    redirect_to @user
  end

  def participation
    @comments = current_user.comments
    @answers = current_user.written_answers
    @questions = []
    @comments.each do |c|
      @questions.push c.answer.question
    end
    @answers.each do |a|
      @questions.push a.question
    end
    @questions.uniq!
  end

  def my_questions
    @questions = current_user.questions
  end

  private

  def correct_user
    @user=User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
