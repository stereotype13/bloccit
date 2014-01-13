class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  belongs_to :user
  belongs_to :topic
  attr_accessible :body, :title, :topic, :post_image

  default_scope order('rank DESC')

  validates :title, length: { minimum: 5}, presence: true
  validates :body, length: {minimum: 20}, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  after_create :create_vote

  mount_uploader :post_image, PostImageUploader

  def up_votes
    self.votes.where(value: 1).count
  end

  def down_votes
    self.votes.where(value: -1).count
  end

  def points
    self.votes.sum(:value).to_i
  end

  def update_rank
    age = (self.created_at - Time.new(1970,1,1)) / 86400
    new_rank = points + age
    self.update_attribute(:rank, new_rank)
  end

  private

  #Whoever create a post would probably want to "up-vote" it, so let's just do it for them.
  def create_vote
    self.user.votes.create(value: 1, post: self)
  end
end
