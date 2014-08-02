class Product < ActiveRecord::Base
    validate :title, uniques: true
    validates :title, :description, :image_url, presence: true
    validates :price, numericality: {greater_than_or_equal_to: 0.01}
    validates :image_url, allow_blank: true, format: {
        with: %r{\.(gif|jpg|png)\Z}i,
        message: 'must be a URL for GIF, JPG or PNG image'
    }
    has_many :line_items
    before_destroy :ensure_not_referenced_by_any_line_item

    def self.latest
        Product.order(:updated_at).last
    end

    private
    def ensure_not_referenced_by_any_line_item
        return true if line_items.empty?
        errors.add :base, 'Line Items present'
        return false
    end
end
