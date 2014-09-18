def dodir(location = 'Users/mcoomey/rails_projects')
  all_files = []
  File.find(location) do |f|
    all_files << f
  end
  puts ">>>>>all_files = #{all_files}<<<<<<<<<<<"
end

