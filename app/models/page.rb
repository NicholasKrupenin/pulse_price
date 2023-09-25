class Page < ApplicationRecord
  has_ancestry

  validates :name, presence: true, uniqueness: true, format: { with: /\A[\wа-яА-Я]+\z/ }
  validates :title, presence: true
  validates :content, presence: true

  def hash_tree
    subtree.arrange
  end

  def build_name
    Page.where(id: path_ids).pluck(:name).join('/')
  end
end
