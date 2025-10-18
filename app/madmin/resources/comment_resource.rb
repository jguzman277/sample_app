class CommentResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :body
  attribute :created_at, form: false
  attribute :updated_at, form: false
  attribute :notification_sent
  attribute :notification_read

  # Associations
  attribute :post
  attribute :user

  # Add scopes to easily filter records
  # scope :published

  # Add actions to the resource's show page
  # member_action do |record|
  #   link_to "Do Something", some_path
  # end

  # Customize the display name of records in the admin area.
  def self.display_name(record)
    "Comment ##{record.id} on #{PostResource.display_name(record.post)}"
  end

  # Customize the default sort column and direction.
  def self.default_sort_column = "created_at"

  def self.default_sort_direction = "desc"
end
