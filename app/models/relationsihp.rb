# == Schema Information
#
# Table name: relationsihps
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  follower_id  :bigint           not null
#  following_id :bigint           not null
#
# Indexes
#
#  index_relationsihps_on_follower_id   (follower_id)
#  index_relationsihps_on_following_id  (following_id)
#
# Foreign Keys
#
#  fk_rails_...  (follower_id => users.id)
#  fk_rails_...  (following_id => users.id)
#
class Relationsihp < ApplicationRecord
    belongs_to :follower, class_name: 'User'
    belongs_to :following, class_name: 'User'

    after_create :send_email 

    private
    def send_email
        RelationshipMailer.notice_follower(following, follower).deliver_now
    end
end
