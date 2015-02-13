class PreloadParts
  def self.preload
    part = DiscourseReports::Part.find_or_initialize_by(name: 'Why Continuous Security?')
    part.save!

    [
      DiscourseReports::Chapter.find_or_initialize_by(name: 'The Waterfall Tapped out'),
      DiscourseReports::Chapter.find_or_initialize_by(name: 'Why Software Security?'),
      DiscourseReports::Chapter.find_or_initialize_by(name: 'Social Security for the Trillions')
    ].each do |chapter|
      chapter.part = part
      chapter.save!
    end
  end
end
