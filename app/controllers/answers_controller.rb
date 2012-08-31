class AnswersController < ApplicationController
  before_filter :signed_in_user

  	def new
  		@question = Question.find(params[:question_id])
  		@user = User.find(params[:user_id])
  		@answer = @question.answers.build
  	end

	def create
		@question = Question.find(params[:question_id])
		@user = User.find(params[:user_id])
		@answer = @question.answers.build(params[:answer])
		if @answer.save
			flash[:success] = "Pregunta respondida!"
			redirect_to user_question_path(@user, @question)
		else
			render root_path
		end
	end

	def destroy
	end

	def update
		@question = Question.find(params[:question_id])
		@user = User.find(params[:user_id])
		@answer = Answer.find(params[:id])
		@score = @user.score+10
    	@user.update_attribute(:score, @score) 
	    if @answer.update_attributes(points: 1) 
	      	flash[:success] = "Calificada!"
	      	redirect_to user_question_path(@user, @question)
	    else
	      redirect_to user_question_path(@user, @question)
    	end
  	end

end