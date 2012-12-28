class UserMailer < ActionMailer::Base
  default from: "registrar@answercompanion.com"
  
  def conversion_submitted(user, video)
    @user = user
    @video = video
    mail(:to => user.email, :from => "Do_Not_Reply@answercompanion.com", :subject => "Video conversion submitted")
  end

  def conversion_complete(user, video)
    @user = user
    @video = video
    mail(:to => user.email, :from => "Do_Not_Reply@answercompanion.com", :subject => "Video conversion completed")
  end
end
