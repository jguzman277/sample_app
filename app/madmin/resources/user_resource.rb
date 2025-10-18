class UserResource < Madmin::Resource
  # Attributes
  attribute :id, form: false
  attribute :email
  attribute :first_name
  attribute :last_name
  attribute :admin
  attribute :active
  attribute :encrypted_password, form: false
  attribute :reset_password_token, form: false
  attribute :reset_password_sent_at, form: false
  attribute :remember_created_at, form: false 
  attribute :created_at, form: false
  attribute :updated_at, form: false

  # Associations
  attribute :posts
  attribute :comments

  # Add scopes to easily filter records
  # scope :published

  # Add actions to the resource's show page
  # member_action do |record|
  #   link_to "Do Something", some_path
  # end

  # Customize the display name of records in the admin area.
  def self.display_name(record)
    if record.first_name.present? && record.last_name.present?
      "#{record.first_name} #{record.last_name}"
    else
      record.email
    end
  end

  # Customize the default sort column and direction.
  # def self.default_sort_column = "created_at"
  #
  # def self.default_sort_direction = "desc"
end
