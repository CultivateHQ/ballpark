module SponsorsHelper
  def new_sponsor_style
    "display:none;" unless notice.present? || (@sponsor && !@sponsor.errors.empty?)
  end
end
