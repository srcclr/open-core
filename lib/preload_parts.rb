class PreloadParts
  def self.preload
    parts = {
      'Why Continuous Security?' => [
        'The Waterfall Tapped out',
        'Why Software Security?',
        'Social Security for the Trillions',
        'The Developer-Centered Value Proposition',
        'Getting the Golden Ticket'
      ],

      'Continuous Security Explained' => [
        'Introduction to Continuous Security',
        'The Continuous Security Process',
        'Continuous Security Tools',
        'Running a Continuous Security Program'
      ],

      'Fundamentals' => [
        'Introduction to Security Fundamentals',
        'Security Bugs',
        'Security Building Blocks'
      ],

      'Technologies' => [],
      'Recipes' => []
    }

    parts.each do |part_name, chapters|
      part = DiscourseReports::Part.find_or_initialize_by(name: part_name)

      chapters.each do |chapter_name|
        chapter = DiscourseReports::Chapter.find_or_initialize_by(name: chapter_name)
        chapter.part = part
        chapter.save!
      end
    end
  end
end
