module SuppliersHelper

  def highlighted_review_excerpt(supplier)
    return if supplier.reviews.empty?

    highlighted_review = supplier.random_median_review
    "\"#{highlighted_review.body.truncate(150, separator: " ", omission: "... ")}\""
  end

end
