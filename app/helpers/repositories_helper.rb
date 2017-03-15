module RepositoriesHelper

def traversal
  @root={}
  @array=[]
  @folder ={}
  @combine= []
  @newarr= []
  @file.each do |f|
    if f.include?('/')
      @combine<<f
      elsif(File.file?(f))
        @array<<f
    end
  end

  while @combine.any? do
    puts"combine#{@combine}"
    text=@combine.first.split('/')
    @combine=get_array(@combine,text)
    puts "newcombine= #{@combine}"
  end
  @array<<@folder
end

def get_array(combine,text)
  newarray=[]
  combine.each do |c|
    if c.include?(text.first)
      @store=text.first
      subfile=c.split('/')
      newarray<<subfile.second
      combine-=[c]
    end
  end
    @folder[@store]=newarray
  return combine
end
end
