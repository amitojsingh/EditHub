module RepositoriesHelper

def traversal
dirMap={}
partsOfPath=[]
dirTree={}
parents=[]
tree=[]
newtree=[]
@finalTree={}
@html=''
@file.each do |path|
  partsOfPath=rasta(path)
  tree<<path.split('/').first
  puts "files or directories inside #{path}"
  (0...partsOfPath.length).each do |i|
    fileDir=partsOfPath[i];
    puts "#{fileDir}"
    if (!dirMap[fileDir])
      dirMap[fileDir]=[partsOfPath[i+1]]
    else
      if (!dirMap[fileDir].include?(partsOfPath[i+1]))
      dirMap[fileDir].push(partsOfPath[i+1])
    end
  end
end
end
puts "#{dirMap}"

dirMap.each do |key,value|
  if(!(dirMap[key].length===1 && dirMap[key][0]=== nil))
    parents<<key
  end
end
puts "parents are #{parents}"

parents.each do |key|
  dirMapValue=dirMap[key]
  dirMap.each do |jkey,jvalue|
    isKeyInValue=dirMap[jkey].include?(key)
    if (isKeyInValue)
      indexOfKeyInValue=dirMap[jkey].index("#{key}")
      puts "#{jkey} contains #{key} at index #{indexOfKeyInValue}"
      myobj={}
      myobj[key]=dirMap[key]
      puts "object to add at index #{indexOfKeyInValue} is #{myobj}"
      dirMap[jkey][indexOfKeyInValue]={}
      dirMap[jkey][indexOfKeyInValue][key]=dirMap[key]
      dirTree[jkey]=dirMap[jkey]

    else
      dirTree[jkey]=dirMap[jkey]
    end
  end
end
#puts "#{dirTree}"

newtree<<tree.uniq
newtree.each do |element|
  element.each do |e|
    @finalTree[e]=dirTree[e]
  end
end
puts "#{@finalTree}"
@html<<"<ul>"
if @finalTree.is_a?(Hash)
  mainlist=callHash(@finalTree)
end
@html<<mainlist
@html<<"</ul>"
return @html
end
def rasta(path)
  x=path.split('/')
  @y=[]
  (0...x.length).each do |i|
    (0...i+1).each do |j|
      if !@y[i].nil?
        @y[i]="#{@y[i]}/#{x[j]}"
        else
        @y[i]=x[j]
      end
    end
  end
  return @y
end

def callHash(hashtree)
  list=""
  hashtree.each do |key,value|
    if key.include?('/')
      list<<"<li>#{key.split('/').last}"
    else
      list<<"<li>#{key}"
    end
    if value.is_a?(Array)
      list<<callArray(value)
    else
      list<<"</li>"
    end
  end
  list<<"</li>"
  return list
end

def callArray(value)
  sublist="<ul class=list>"
  value.each do |v|
    unless v==nil
      if v.is_a?(Hash)
        sublist<<callHash(v)
      else
        if v.include?('/')
          sublist<<"<li>#{v.split('/').last}</li>"
        else
          sublist<<"<li>#{v}</li>"
        end
      end
    end
  end
  sublist<<"</ul></li>"
  return sublist
end
end
