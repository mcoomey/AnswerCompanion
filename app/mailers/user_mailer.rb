class UserMailer < ActionMailer::Base
  default from: "registrar@answercompanion.com"
  
  def conversion_submitted(email, video)
    @video = video
    mail(:to => email, :from => "Do_Not_Reply@answercompanion.com", :subject => "Video conversion submitted")
  end

  def conversion_complete(email, video)
    @video = video
    mail(:to => email, :from => "Do_Not_Reply@answercompanion.com", :subject => "Video conversion completed")
  end
end
