# This generates repository tree
module RepositoriesHelper
def traversal
  dir_map = {}
  parts_of_path = []
  dir_tree = {}
  parents = []
  tree = []
  newtree = []
  @final_tree = {}
  @html = ''
  @file.each do |path|
    parts_of_path = rasta(path)
    tree << path.split('/').first
    puts "files or directories inside #{path}"
    (0...parts_of_path.length).each do |i|
      file_dir = parts_of_path[i]
      puts file_dir
      if !dir_map[file_dir]
        dir_map[file_dir] = [parts_of_path[i + 1]]
      else
        unless dir_map[file_dir].include?(parts_of_path[i + 1])
          dir_map[file_dir].push(parts_of_path[i + 1])
        end
      end
    end
  end
  puts dir_map

  dir_map.each do |key, _value|
    unless dir_map[key].length === 1 && dir_map[key][0] === nil
      parents << key
    end
  end
  puts "parents are #{parents}"

  parents.each do |key|
    dir_map.each do |jkey, _jvalue|
      is_key_in_value = dir_map[jkey].include?(key)
      if is_key_in_value
        index_of_key_in_value = dir_map[jkey].index(key)
        puts "#{jkey} contains #{key} at index #{index_of_key_in_value}"
        myobj = {}
        myobj[key] = dir_map[key]
        puts "object to add at index #{index_of_key_in_value} is #{myobj}"
        dir_map[jkey][index_of_key_in_value] = {}
        dir_map[jkey][index_of_key_in_value][key] = dir_map[key]
      end
      dir_tree[jkey] = dir_map[jkey]
    end
  end
  # puts "#{dir_tree}"

  newtree << tree.uniq
  newtree.each do |element|
    element.each do |e|
      @final_tree[e] = dir_tree[e]
    end
  end
  puts @final_tree
  @html << '<ul>'
  if @final_tree.is_a?(Hash)
    mainlist = callHash(@final_tree)
    puts "mainlist----#{mainlist}"
  end
  @html << mainlist
  @html << '</ul>'
  return @html
end
end

def rasta(path)
  x = path.split('/')
  @y = []
  (0...x.length).each do |i|
    (0...i + 1).each do |j|
      if !@y[i].nil?
        @y[i] = "#{@y[i]}/#{x[j]}"
      else
        @y[i] = x[j]
      end
    end
  end
  return @y
end

def callHash(hashtree)
  list = ''
  hashtree.each do |key, value|
    if value.is_a?(Array)
      if key.include?('/')
        list << "<li class='folder'>"
        list << "<span>#{key.split('/').last}</span>"
      else
        if (value - [nil]).empty?
          list << "<li class='file' id = #{key}>"
          list << link_to(key, '#', dataurl: generate_repository_url(name: key), class: "link", rel: key)
        else
          list << "<li class='folder'>"
          list << "<span>#{key}</span>"
        end
      end
      list << callArray(value)
    else
      list << "<li class=file id = #{key}>"
      list << link_to(key, '#', dataurl: generate_repository_url(name: key), class: "link", rel: key)
      list << '</li>'
    end
  end
  list << '</li>'
  return list
end

def callArray(value)
  sublist = "<ul class='list'>"
  value.each do |v|
    unless v.nil?
      if v.is_a?(Hash)
        sublist << callHash(v)
      else
        sublist << "<li class='file' id= #{v}>"
        if v.include?('/')
          sublist << link_to(v.split('/').last, '#', dataurl: generate_repository_url(name: v), class: "link", rel: v)
          sublist << '</li>'
        else
          sublist << link_to(v, '#', dataurl: generate_repository_url(name: v), class: "link", rel: v)
        end
      end
    end
  end
  sublist << '</ul></li>'
  return sublist
end
