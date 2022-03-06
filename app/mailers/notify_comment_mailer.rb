class NotifyCommentMailer < ApplicationMailer
   
    def notify_comment(user, comment_user)
        @user = user
        @comment_user = comment_user
        mail to: user.email, subject: '【お知らせ】メンションされました'
    end
end