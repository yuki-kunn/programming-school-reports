module Admin::UsersHelper
  def user_role_badge(user)
    if user.superadmin?
      content_tag(:span, "スーパー管理者",
        class: "inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium bg-violet-100 text-violet-700")
    elsif user.admin?
      content_tag(:span, "管理者",
        class: "inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium bg-indigo-100 text-indigo-700")
    else
      content_tag(:span, "一般",
        class: "inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-medium bg-slate-100 text-slate-600")
    end
  end
end
