class Recipe < ApplicationRecord
  validates :title, :description, :ingredients, :directions, presence: true

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :photo,  content_type: /\Aimage\/.*\z/

  has_many :ingredients, dependent: :destroy
  has_many :directions, dependent: :destroy

  accepts_nested_attributes_for  :ingredients,
                                reject_if: proc { |attributes| attributes['name'].blank? },
                                allow_destroy: true
  accepts_nested_attributes_for  :directions,
                                reject_if: proc { |attributes| attributes['step'].blank? },
                                allow_destroy: true
end
