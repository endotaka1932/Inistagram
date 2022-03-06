# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  content     :text
#  likes_count :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
    belongs_to :user

    validates :images, presence: true

    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy

    has_many_attached :images


    def display_created_at
        I18n.l(self.created_at, format: :default)
    end


end
