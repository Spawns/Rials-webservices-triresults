class Placing
  #include Mongoid::Document

  attr_accessor :name, :place

  def initialize name, place
    @name = name
    @place = place
  end

  def mongoize
    {:name=>@name, :place=>@place}
  end

  def self.mongoize(object)
    case object
      when Placing then object.mongoize
      when Hash then
        Placing.new(object[:name], object[:place]).mongoize
      when nil then nil
    end
  end

  def self.demongoize object
    case object
      when nil then nil
      when Hash then
        Placing.new(object[:name], object[:place])
      when Placing then object
    end
  end

  def self.evolve object
    case object
      when nil then nil
      when Hash then object
      when Placing then object.mongoize
    end
  end

end
