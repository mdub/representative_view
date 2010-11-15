module Books

  def all
    [
      OpenStruct.new(
      :title => "Sailing for old dogs", 
      :authors => ["Jim Watson"],
      :published => OpenStruct.new(
      :by => "Credulous Print",
      :year => 1994
      )
      ),
      OpenStruct.new(
      :title => "On the horizon", 
      :authors => ["Zoe Primpton", "Stan Ford"],
      :published => OpenStruct.new(
      :by => "McGraw-Hill",
      :year => 2005
      )
      ),
      OpenStruct.new(
      :title => "The Little Blue Book of VHS Programming",
      :authors => ["Henry Nelson"],
      :rating => "****"
      )
    ]
  end
  
  extend self
  
end
