class CommentsController < ApplicationController
  
  def new
  	@answer = Answer.find(params[:answer_id])
  	@comment = @answer.comments.build
  	@user = @answer.writer
  	@question = @answer.question
  end

  def create
  		@answer = Answer.find(params[:answer_id])
  		@question = Question.find(params[:question_id])
		@user = User.find(params[:user_id])
		@asker = @question.user
		@comment = @answer.comments.build(params[:comment])
		if @comment.save
			flash[:success] = "Comentario enviado."
			redirect_to user_question_path(@user, @question)
		else
			render 'new'
		end
  end

end
