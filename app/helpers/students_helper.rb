module StudentsHelper
  ENROLLMENT_STATUS_LABELS = {
    "active"    => "在籍中",
    "graduated" => "卒業",
    "on_leave"  => "休学中",
  }.freeze

  def enrollment_status_label(status)
    ENROLLMENT_STATUS_LABELS[status.to_s] || status.to_s
  end

  def enrollment_status_badge_class(status)
    case status.to_sym
    when :active    then "bg-emerald-100 text-emerald-700"
    when :graduated then "bg-blue-100 text-blue-700"
    when :on_leave  then "bg-amber-100 text-amber-700"
    else                 "bg-slate-100 text-slate-700"
    end
  end
end
