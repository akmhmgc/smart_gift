module ApplicationHelper
  def rounding_stars(stars_count)
    # .5刻みで切り捨て
    (stars_count * 2).floor / 2.0
  end
end
