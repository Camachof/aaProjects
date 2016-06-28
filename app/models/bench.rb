
class Bench < ActiveRecord::Base
  validates :description, :lat, :lng, presence: true

  def self.in_bounds(bounds)
    benches = []
    sw = bounds["southWest"]
    ne = bounds["northEast"]
    Bench.all.each do |bench|
      if bench.lat.between?(sw["lat"].to_f, ne["lat"].to_f)
        if bench.lng.between?(sw["lng"].to_f, ne["lng"].to_f)
          benches << bench
        end
      end
    end
    puts benches
    benches
  end

end
