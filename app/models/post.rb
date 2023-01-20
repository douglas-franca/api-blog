class Post < ApplicationRecord
    has_and_belongs_to_many :tags, before_add: :check_tag
    has_many :comments, dependent: :destroy
    has_many :likes, as: :likeable, dependent: :destroy
    belongs_to :user

    validates :title, length: { within: 10..255}, uniqueness: true
    validates :description, length: { minimum: 10 }

    private

    def check_tag(tag)
        if self.tags.include?(tag)
            raise ActiveRecord::RecordNotUnique, "Tag #{tag.id} já está associada ao post"
        end
    end

end
