class User < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :name, :email, :password, :password_confirmation, :admin, :department, :department_id, :department_name
  
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email"
  validates_length_of :name, :within => 3..40
  validates_uniqueness_of :email
	validates_presence_of  :password, on: :create
  validates_confirmation_of :password
  before_create { generate_token(:auth_token) }
  
  belongs_to :department
  has_many :assignments
  has_many :roles, :through => :assignments
  
  scope :administrators, where("assignments.role_id = 1").joins(:assignments)
  scope :customers, where("assignments.role_id IS NULL").includes(:assignments)
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  def department_name
    department.try(:name)
  end

  def department_name=(name)
    self.department = Department.find_or_create_by_name(name) if name.present?
  end
  
  def role?(role)
		roles.map{|x| x.name}.include? role.to_s
	end

end
