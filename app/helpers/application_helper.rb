module ApplicationHelper
  def has_errors_for?(obj, field)
    "has-error" if obj.errors[field].any?
  end

  def errors_for(obj, field)
    obj.errors[field][0]
  end
end
