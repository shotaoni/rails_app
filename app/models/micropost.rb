# == Schema Information
#
# Table name: microposts
#
#  id         :bigint           not null, primary key
#  content    :text(65535)
#  image      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_microposts_on_user_id                 (user_id)
#  index_microposts_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, length: { maximum: 255 }
  validates :only_user_id, presence: true
  validates :image, content_type: { in: %w[image/jpeg image/gif image/png],
                                    message: '画像はjpeg, gif, png形式のみになります。' },
                    size: { less_than: 5.megabytes,
                            message: '５MBを超えた画像の投稿はできません。' }

  # 表示用のリサイズ済み画像を返す
  def display_image
    image.variant(resize_to_limit: [500, 500])
  end

  private

  def only_user_id
    content.presence or image.attached?
  end
end
