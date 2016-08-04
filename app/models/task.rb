class Task < ActiveRecord::Base

	has_paper_trail
  validates :name, :length => { :minimum => 3 }

	belongs_to :priority
	belongs_to :component
	belongs_to :state
	belongs_to :task_type
	belongs_to :dept, class_name: 'TaskDept',foreign_key: :dept_id
	belongs_to :user
	belongs_to :client
  belongs_to :executor, class_name: 'User'

	attr_accessor :client_name

	def priority_name
		priority.try(:name)
	end

	def state_name
		state.try(:name)
	end

	def task_type_name
		task_type.try(:name)
	end

	def dept_name
		dept.try(:name)
	end

	def user_name
  	user.try(:name)
  end

	def component_name
  	component.try(:name)
  end

  def client_name
    #author.name if !author.nil?
    client.try(:name)
  end

  def executor_name
    #author.name if !author.nil?
    executor.try(:name)
  end

  def client_name=(name)
    self.client = Client.find_or_create_by(name: name) if name.present?
  end


end
