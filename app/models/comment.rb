# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#  index_comments_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord
    belongs_to :article
    belongs_to :user

    validates :content, presence: true

    after_create :comment_include_username

    private
    def comment_include_username
        comment_user = User.find(user_id)
        User.all.each do |user|
            word = "@#{user.username}"
            if content.include?(word)
                NotifyCommentMailer.notify_comment(user, comment_user).deliver_later
            end
        end
    end
end
