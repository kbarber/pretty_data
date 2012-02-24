#!/usr/bin/env ruby

hash = {
  "a" => {
    "a" => "b",
    "c" => "d",
  },
  "b" => ["asdf", "bfgh"],
  "c" => "word",
  "d" => false,
  "e" => { "a" => ["test", "foo"] },
  "f" => [["a","b","c"],["d","e",{ "foo" => "bar" }]],
  "g" => [
    {
      "foo" => "asdf",
      "bar" => "asdf",
    },
    {
      "foo" => "asdf",
      "bar" => "asdf",
    },
  ],
}

def facter_data(data)
  data.sort.each do |e|
    k,v = e
    $stdout.write("\e[33m$#{k}\e[0m = ")
    pretty_data(v)
  end
end

def pretty_data(data, indent = 0)
  case data
  when Hash
    puts "\e[38;5;104m{\e[0m"
    indent = indent+1
    data.sort.each do |e|
      k,v = e
      indent(indent)
      $stdout.write "\e[32m\"#{k}\"\e[0m => "
      case v
      when String,TrueClass,FalseClass
        pretty_data(v)
      when Hash,Array
        pretty_data(v, indent)
      end
    end
    indent(indent-1)
    puts "\e[38;5;104m}\e[0m,"
  when Array
    puts "\e[38;5;104m[\e[0m"
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
    puts "\e[38;5;104m]\e[0m,"
  when TrueClass,FalseClass
    puts "\e[32m#{data}\e[0m,"
  when String
    puts "\e[32m\"#{data}\"\e[0m,"
  end
end

def indent(num, indent = "  ")
  num.times { $stdout.write(indent) }
end

puts hash.inspect
#pretty_data(hash)
facter_data(hash)
