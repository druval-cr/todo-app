class PriorityValidator < ActiveModel::Validator
    def validate(record)
      if record.priority != "high" && record.priority != "medium" && record.priority != "low" 
        record.errors.add :base, "Assign a valid priority"
      end
    end
  end
  
class Todo < ApplicationRecord
    validates :content, presence: true
    validates :due_date, presence: true
    validates_with PriorityValidator
end
