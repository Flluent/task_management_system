module ApplicationHelper
  def sort_direction(column)
    if column == params[:sort]
      params[:direction] == "asc" ? "desc" : "asc"
    else
      "asc"
    end
  end
end
