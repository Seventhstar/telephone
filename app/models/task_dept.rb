class TaskDept < ActiveRecord::Base
	has_many :tasks,foreign_key: :dept_id
end
