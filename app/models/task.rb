class Task < ApplicationRecord
  belongs_to :user

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
