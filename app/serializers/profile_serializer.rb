# == Schema Information
#
# Table name: profiles
#
#  id           :bigint           not null, primary key
#  introduction :text
#  nickname     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :avatar_url

  belongs_to :user

  def avatar_url
    rails_blob_path(object.avatar_image) if object.avatar_image.attached?
  end

end
