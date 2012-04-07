class Post

  include Cequel::Model

  key :id, :integer
  column :title, :varchar
  column :body, :varchar
  column :blog_id, :integer

  before_save :record_save_callback
  before_create :record_create_callback
  before_update :record_update_callback
  before_destroy :record_destroy_callback
  before_validation :record_validation_callback

  validates :title, :presence => true, :if => :require_title?

  attr_writer :require_title

  def self.for_blog(blog_id)
    where(:blog_id => blog_id)
  end

  def has_callback?(callback)
    callbacks.include?(callback)
  end

  def require_title?
    !!@require_title
  end

  private

  def record_save_callback
    record_callback(:save)
  end

  def record_create_callback
    record_callback(:create)
  end

  def record_update_callback
    record_callback(:update)
  end

  def record_destroy_callback
    record_callback(:destroy)
  end

  def record_validation_callback
    record_callback(:validation)
  end

  def record_callback(callback)
    callbacks << callback
  end

  def callbacks
    @callbacks ||= Set[]
  end

end
