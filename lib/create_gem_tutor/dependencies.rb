class Object
  def self.const_missing(const)
    require CreateGemTutor.to_underscore(const.to_s)
    Object.const_get(const)
  end
end
