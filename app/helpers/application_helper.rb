module ApplicationHelper
  def flash_class(type)
    case type.to_sym
    when :notice, :success
      "bg-emerald-50 text-emerald-800 border border-emerald-200"
    when :alert, :error
      "bg-red-50 text-red-800 border border-red-200"
    when :warning
      "bg-amber-50 text-amber-800 border border-amber-200"
    else
      "bg-slate-50 text-slate-800 border border-slate-200"
    end
  end

  # nil-safe: nilの場合は "—" を返す
  def japanese_date(date)
    return "—" if date.nil?
    date.strftime("%Y年%-m月%-d日")
  end
end
