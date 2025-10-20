class Task < ApplicationRecord
  belongs_to :property
  
  enum :task_type, { 
    cleaning: 'cleaning', 
    maintenance: 'maintenance', 
    inspection: 'inspection' 
  }
  
  enum :status, { 
    pending: 'pending', 
    in_progress: 'in_progress', 
    done: 'done' 
  }
  
  validates :description, :task_type, :assigned_person, :status, :date, presence: true
end