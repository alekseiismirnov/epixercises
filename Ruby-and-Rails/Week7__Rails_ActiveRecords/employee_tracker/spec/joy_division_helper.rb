class JoyDivision

  attr_reader :divisions_names

  def initialize
    @divisions_names = %w[HR IT IQ ICQ Sales Pre-Sales Post-Sales]

    Division.delete_all
    Division.insert_all(@divisions_names.map { |name| { name: name } })
  end
end
