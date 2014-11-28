class Archetype
  def self.find(id)
    list.find { |archetype| archetype.id == id }
  end
end
