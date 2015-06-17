class Picture < ActiveRecord::Base
  belongs_to :place

  has_attached_file :file, styles: { medium: '800x800>', thumb: '100x100>' }
  validates_attachment_presence :file
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/
end
