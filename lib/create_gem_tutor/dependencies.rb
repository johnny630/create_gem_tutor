class Object
  def self.const_missing(const)
    # prevent not found controller file
    return nil if @called_const_missing

    @called_const_missing = true
    require CreateGemTutor.to_underscore(const.to_s)
    klass = Object.const_get(const)
    @called_const_missing = false
    klass
  end
end
