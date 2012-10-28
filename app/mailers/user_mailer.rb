class UserMailer < ActionMailer::Base
  default :from => "info.solucionario@gmail.com"
  
  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Bienvenido a Solucionario!")
  end

    def answer_written(user, question)
    @user = user
    @question = question
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Respondieron tu pregunta!")
  end

    def new_score(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Ganaste puntos!")
  end
end