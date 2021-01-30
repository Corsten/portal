class PilotReporterDecorator < ApplicationDecorator
  def category_name
    object.group.category.name
  end

  def group_name
    object.group.name
  end
end
