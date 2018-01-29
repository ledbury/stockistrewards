class Import < ApplicationRecord
  has_attached_file :file
  belongs_to :shop
  validates :file, presence: :true
  validates_attachment_content_type :file, :content_type => ["text/csv"]
  after_commit :process

  private

  def process
    Stockist.import_csv(self.shop, file = "stockists.csv")
  end
end
