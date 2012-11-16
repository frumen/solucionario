class QuestionsController < ApplicationController
  before_filter :signed_in_user

  def new
  	@question = current_user.questions.build
  end

  def create
  	@question = current_user.questions.build(params[:question])
  	if @question.save
  		flash[:success] = "Su consulta se ha publicado con exito."
  		redirect_to root_path
  	else
  		render 'new'
  	end
  end

  def show
    @question = Question.find(params[:id])
    @user = @question.user
    if current_user==@user
      @answers = @question.answers.where("available = 1 and rejected = 0")
    else
      @answers = @question.answers.where("rejected = 0")
    end
    @useful=0
    @answers.each do |a|
      @useful=@useful+a.points
    end
    @shown=0
    @answers.each do |a|
      @shown=@shown+a.available
    end
    @answer_count = @question.answers.count - @question.answers.where("rejected = 1").count
  end

  def update
    @question = Question.find(params[:id])
    @user = current_user
    @answers = @question.answers.where("available = 0").slice(0,3)
    if @question.level==1
      @score = @user.score-40
    elsif @question.level==2
      @score = @user.score-80
    else
      @score = @user.score-120
    end
    @user.update_attribute(:score, @score)
    sign_in @user
    @answers.each do |a| 
     a.update_attribute(:available, 1) 
    end
    redirect_to user_question_path(@user, @question)
  end

  def index
    @user = current_user
    @areas = current_user.areas
    @areacods = []
    @areas.each do |a|
      @areacods.push(a.id)
    end
    @questions = Question.find_all_by_area_id(@areacods)
    if !@questions.empty?
      @questions.each do |q|
        if q.user_id==@user.id
          @questions.delete(q)
        end
      end
    end
    if !@questions.empty?
      @questions.each do |q|
        if q.answers.any?
          ids = []
          q.answers.each do |a|
            if a.writer
              ids.push(a.writer.id)
            end
          end
          if ids.include?(@user.id)
            @questions.delete(q)
          end
        end
      end
    end
    if !@questions.empty?
      @questions.each do |q|
        if q.solved==1
          @questions.delete(q)
        end
      end
    end
  end

  def refund
    @question = Question.find(params[:id])
    @user = current_user
    @rej_answers = @question.answers.where("available = 1")
    @rej_answers.each do |a| 
     a.update_attribute(:rejected, 1) 
    end
    @answers = @question.answers.where("available = 0").slice(0,3)
    @answers.each do |a| 
     a.update_attribute(:available, 1) 
    end
    redirect_to user_question_path(@user, @question)
  end

  def closed
    @questions = Question.where("solved = 1")
  end

  def destroy
  end
end