class Film
  attr_reader :name, :producer, :year_of_issue

  def initialize(name, producer, year_of_issue)
    @name = name
    @producer = producer
    @year_of_issue = year_of_issue
  end

  def self.from_file(path)
    file = File.readlines(path, encoding: 'UTF-8', chomp: true)
    self.new(file[0], file[1], file[2])
  end

  def to_s
    "#{@producer} - #{@name} (#{@year_of_issue})"
  end

end
