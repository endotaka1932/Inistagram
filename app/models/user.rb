# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_one :profile, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :favorites_articles, through: :likes, source: :article

  has_many :comments, dependent: :destroy

  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationsihp', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following

  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationsihp', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  def has_written(article)
    articles.exists?(id: article.id)
  end

  def has_liked(article)
    likes.exists?(article_id: article.id)
  end

  def likes_count
    likes.count
  end

  def articles_count
    articles.count
  end

  def follow!(user)
    user_id = get_user_id(user)
    following_relationships.create(following_id: user_id)
  end

  def has_followed?(user)
    user_id = get_user_id(user)
    following_relationships.exists?(following_id: user_id)
  end

  def unfollow!(user)
    user_id = get_user_id(user)
    relation = following_relationships.find_by!(following_id: user_id)
    relation.destroy!
  end

  def prepare_profile
    profile || build_profile
  end

  def display_name
    if profile.present?
      profile.nickname
    else
      self.username
    end
  end

  def display_introduction
    if profile.present?
      profile.introduction
    else
      ' '
    end
  end

  def avatar_image
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default.png'
    end
  end

  private
    def get_user_id(user)
      if user.is_a?(User)
        user.id
      else
        user
      end
    end
end
