SiteSetting.class_eval do
  @types = Enum.new(:string, :time, :fixnum, :float, :bool, :null, :enum, :list, :url_list, :textarea)
end
