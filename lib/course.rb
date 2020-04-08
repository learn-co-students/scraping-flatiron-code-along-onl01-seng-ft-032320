class Course

    #### Attributes ####
    attr_accessor :title, :schedule, :description
    @@all = []

    #### Instance Methods ####
    def initialize
        @@all << self
    end

    #### Class Methods####
    def self.all
        @@all
    end

    def self.reset_all
        @@all.clear
    end
end
