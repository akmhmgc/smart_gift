module ApplicationHelper
  def rounding_stars(stars_count)
    # .5刻みで切り捨て
    (stars_count * 2).floor / 2.0
  end

  def errors_hash(resource)
    resource.errors.messages.map do |col, errors_array|
      [col, errors_array.map { |error| resource.class.human_attribute_name(col) + error }]
    end.to_h
  end
end
