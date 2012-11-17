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
		@cuser = current_user
		if @question.level==1
			@score = @cuser.score+10
		elsif @question.level==2
			@score = @cuser.score+20
		else
			@score = @cuser.score+30
		end
		@answer = @question.answers.build(params[:answer])
		@cur_answers = Answer.find_all_by_question_id(@question.id)
		@i=0
		@cur_answers.each do |a|
			if a.available==1
				@i=@i+1
			end
		end
		if (@i==@cur_answers.length) && (@i.to_f/3 != @i/3)
			@answer.available=1
		end
		if @answer.save
			@mensaje = "Usted ahora tiene #{@score} puntos."
			flash[:success] = @mensaje
			UserMailer.answer_written(@user, @question).deliver
			@cuser.update_attribute(:score, @score) 
			UserMailer.new_score(@cuser).deliver
			sign_in @cuser
			redirect_to user_question_path(@user, @question)
		else
			render 'new'
		end
	end

	def destroy
	end

	def update
		@answer = Answer.find(params[:id])
  		@user = User.find(params[:user_id])
  		@question = Question.find(params[:question_id])
  		if @question.level==1
			@total = 50
		elsif @question.level==2
			@total = 100
		else
			@total = 150
		end
		@fraction=0.0
		if params[:answer][:comments_attributes]
			params[:answer][:comments_attributes].each do |c|
				if c.second[:useful]
					@fraction = @fraction + Integer(c.second[:useful])
				end
			end
			if @fraction<= 50 && @fraction>=0
		  		if @answer.update_attributes(params[:answer])
		  			flash[:success] = "Calificada!"
		  			@question.update_attribute(:solved, 1)
		  			@genius = @answer.writer
		  			@fraction = (100-@fraction)/100
		  			@g_score = @genius.score + (@total*@fraction)
		  			@genius.update_attribute(:score, @g_score)
		  			UserMailer.new_score(@genius).deliver
					@comments = @answer.comments
					@comments.each do |c|
						@score = c.writer.score
						@diferencia = (c.useful*@total)/100
						@score = @score + @diferencia
						if c.writer!=current_user
							c.writer.update_attribute(:score, @score)
							UserMailer.new_score(c.writer).deliver
						end
					end
					redirect_to user_question_path(@user, @question)
		      	else
		      		redirect_to edit_user_question_answer_path(@user, @question, @answer)
		      	end
		      else
		      	flash[:error] = "Error! Los porcentajes de comentarios deben sumar 50 o menos."
		      	redirect_to edit_user_question_answer_path(@user, @question, @answer)
	      	end
	      else
	      	if @answer.update_attributes(params[:answer])
		  		flash[:success] = "Calificada!"
		  		@question.update_attribute(:solved, 1)
		  		@genius = @answer.writer
		  		@fraction = (100-@fraction)/100
		  		@g_score = @genius.score + (@total*@fraction)
		  		@genius.update_attribute(:score, @g_score)
		  		UserMailer.new_score(@genius).deliver
		  		redirect_to user_question_path(@user, @question)
		  	else
		  		redirect_to edit_user_question_answer_path(@user, @question, @answer)
		  	end
      	end
  	end

  	def edit
  		@user = User.find(params[:user_id])
  		@question = Question.find(params[:question_id])
  		@answer = Answer.find(params[:id])
  		@writer = @answer.writer
  		@comments = @answer.comments
  	end

end