class Task < ApplicationRecord
  belongs_to :user
  belongs_to :assignee, class_name: 'User', optional: true
  validates :title, presence: true, uniqueness: true


  STATUS_OPTIONS = {
    "backlog" => "Бэклог",
    "current_focus" => "В фокусе",
    "in_progress" => "В процессе",
    "completed" => "Завершено"
  }.freeze

  PRIORITY_OPTIONS = {
    "low" => "Низкий",
    "medium" => "Средний",
    "high" => "Высокий"
  }.freeze

  def display_status
    STATUS_OPTIONS[status] || status
  end

  def display_priority
    PRIORITY_OPTIONS[priority] || priority
  end
end
