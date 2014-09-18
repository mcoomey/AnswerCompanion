class UserMailer < ActionMailer::Base
  default from: "registrar@answercompanion.com"
  
  def conversion_submitted(email, video, exit_status)
    @video = video
    @exit_status = exit_status
    mail(:to => email, :from => "Do_Not_Reply@answercompanion.com", :subject => "Video conversion submitted")
  end

  def conversion_complete(email, video, exit_status)
    @video = video
    @exit_status = exit_status
    mail(:to => email, :from => "Do_Not_Reply@answercompanion.com", :subject => "Video conversion completed")
  end

  def conversion_failed(email, video, exit_status)
    @video = video
    @exit_status = exit_status
    @error_message = exit_status[:error_message].split(':').last
    mail(:to => email, :from => "Do_Not_Reply@answercompanion.com", :subject => "Video conversion failed")
  end
end
