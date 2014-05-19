class Photo < ActiveRecord::Base
  has_attached_file :attachment, styles: { thumb: "200x200>", exploded: { processors: [:exploder] } }

  validates :title, presence: true
  validates :description, length: { maximum: 250 }, allow_blank: true
  validates_attachment_presence :attachment
  validates_attachment_content_type :attachment, :content_type => /\Aimage/
  validates_attachment_size :attachment, :in => 0.megabytes..2000.kilobytes
end
