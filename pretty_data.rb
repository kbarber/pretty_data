#!/usr/bin/env ruby

hash = {
  "a" => {
    "a" => "b",
    "c" => "d",
  },
  "b" => ["asdf", "bfgh"],
  "c" => "word",
  "d" => false,
}

def pretty_data(data, indent = 0)
  case data
  when Hash
    puts "{"
    indent = indent+1
    data.each do |k,v|
      indent(indent)
      $stdout.write "\"#{k}\" => "
      case v
      when String,TrueClass,FalseClass
        pretty_data(v)
      when Hash,Array
        pretty_data(v, indent)
      end
    end
    indent(indent-1)
    puts "}"
  when Array
    puts "["
    indent = indent+1
    data.each do |e|
      indent(indent)
      case e
      when String,TrueClass,FalseClass
        pretty_data(e)
      when Hash,Array
        pretty_data(e, indent)
      end
    end
    indent(indent-1)
    puts "]"
  when TrueClass,FalseClass
    puts data.to_s
  when String
    puts "\"#{data}\""
  end
end

def indent(num, indent = "  ")
  num.times { $stdout.write(indent) }
end

puts hash.inspect
pretty_data(hash)