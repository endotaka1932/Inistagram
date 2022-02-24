class RelationshipMailer < ApplicationMailer

    def notice_follower(user, follower)
        @user = user
        @follower = follower
        mail to: user.email, subject: '【お知らせ】フォーローされました'
    end
end