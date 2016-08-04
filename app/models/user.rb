class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  belongs_to :dept, class_name: "TaskDept", foreign_key: "dept_id"
  has_many :tasks, class_name: 'Task',foreign_key: 'executor_id'
  scope :with_tasks, -> {includes(:tasks).where.not(tasks: {executor_id:nil})}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, password_length: 4..128


  def self.find_version_author(version)
    find(version.terminator) if version.terminator  
  end


end
