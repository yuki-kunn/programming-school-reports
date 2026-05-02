module StudentsHelper
  def student_status_class(status)
    case status.to_sym
    when :active then "bg-green-100 text-green-800"
    when :graduated then "bg-blue-100 text-blue-800"
    when :on_leave then "bg-yellow-100 text-yellow-800"
    else "bg-gray-100 text-gray-800"
    end
  end
end
