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
  subdir=[]
  combine.each do |c|
     if c.count('/')>1
         subdir<<c
         combine-=[c]
    elsif c.include?(text.first)
      @store=text.first
      subfile=c.split('/')
      newarray<<subfile.second
      combine-=[c]
      puts "newarray = #{newarray}"
    end
  end
     child=loopdir(subdir)
     puts "child = #{child}"
     if child==@store
       newarray<<@shash
     end
     @folder[@store]=newarray
  return combine
end

def loopdir(subdir)
  while subdir.any? do
    puts "subdir #{subdir}"
    parent=subdir.first.split('/')
    subdir=get_subdir(subdir,parent.second)
    puts "new subdir #{subdir}"
    return parent.first
  end
end

def get_subdir(subdir,singleparent)
  newarray=[]
  @shash={}
  children=[]
  subarray=[]
  subdir.each do |s|
    c=s.split('/')
    c.shift
    subarray<<s
      puts "after splitting #{c}"
      children<<c.first

      subdir-=[s]
      end
      puts "child= #{children}"
      children.each do |ch|
          puts"hash = #{@shash}"
          newarray=get_subarray(ch,subarray)
          puts "sub array = #{newarray}"
          @shash[ch]=newarray
          puts "hash= #{@shash}"
        end
  return subdir
end

def get_subarray(child,subarray)
  newarray=[]
  puts"function#{subarray}"
  subarray.each do |s|
    c=s.split('/')
    if c.second==child
      newarray<<c .last
  end
end
return newarray
end
end
