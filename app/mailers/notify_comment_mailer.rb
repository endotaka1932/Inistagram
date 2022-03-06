class NotifyCommentMailer < ApplicationMailer
   
    def notify_comment(user)
        mail to: user.email, subject: 'お知らせ'
    end
end