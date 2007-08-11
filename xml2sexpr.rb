#!/usr/bin/ruby -w

require "rexml/document"

# Script to convert Pingus 0.6 level files to new sexpr format

$typespec_worldmap = 
  [
   [/^\/pingus-worldmap$/, :section],
   [/^\/pingus-worldmap\/head$/, :section],
   [/^\/pingus-worldmap\/head\/author$/, :string],
   [/^\/pingus-worldmap\/head\/default-node$/, :string],
   [/^\/pingus-worldmap\/head\/description$/, :string],
   [/^\/pingus-worldmap\/head\/email$/, :string],
   [/^\/pingus-worldmap\/head\/final-node$/, :string],
   [/^\/pingus-worldmap\/head\/height$/, :integer],
   [/^\/pingus-worldmap\/head\/music$/, :string],
   [/^\/pingus-worldmap\/head\/name$/, :string],
   [/^\/pingus-worldmap\/head\/short-name$/, :string],
   [/^\/pingus-worldmap\/head\/width$/, :integer],
   [/^\/pingus-worldmap\/objects\/surface\/position$/, :vector],
   [/^\/pingus-worldmap\/objects\/surface\/name$/, :string],
   [/^\/pingus-worldmap\/(intro_story|end_story)$/, :section],
   [/^\/pingus-worldmap\/(intro_story|end_story)\/title$/, :string],
   [/^\/pingus-worldmap\/(intro_story|end_story)\/music$/, :string],
   [/^\/pingus-worldmap\/(intro_story|end_story)\/pages$/, :section],
   [/^\/pingus-worldmap\/(intro_story|end_story)\/pages\/page[0-9][0-9]$/, :section],
   [/^\/pingus-worldmap\/(intro_story|end_story)\/pages\/page[0-9][0-9]\/surface$/, :section],
   [/^\/pingus-worldmap\/(intro_story|end_story)\/pages\/page[0-9][0-9]\/surface\/image$/, :string],
   [/^\/pingus-worldmap\/(intro_story|end_story)\/pages\/page[0-9][0-9]\/surface\/modifer$/, :string],
   [/^\/pingus-worldmap\/(intro_story|end_story)\/pages\/page[0-9][0-9]\/text$/, :string],
   [/^\/pingus-worldmap\/graph$/, :section],
   [/^\/pingus-worldmap\/graph\/nodes$/, :section],
   [/^\/pingus-worldmap\/graph\/nodes\/leveldot$/, :section],
   [/^\/pingus-worldmap\/graph\/nodes\/leveldot\/dot$/, :section],
   [/^\/pingus-worldmap\/graph\/nodes\/leveldot\/dot\/name$/, :string],
   [/^\/pingus-worldmap\/graph\/nodes\/leveldot\/dot\/position$/, :vector],
   [/^\/pingus-worldmap\/graph\/nodes\/leveldot\/levelname$/, :string],
   [/^\/pingus-worldmap\/graph\/edges$/, :section],
   [/^\/pingus-worldmap\/graph\/edges\/edge$/, :section],
   [/^\/pingus-worldmap\/graph\/edges\/edge\/name$/, :string],
   [/^\/pingus-worldmap\/graph\/edges\/edge\/source$/, :string],
   [/^\/pingus-worldmap\/graph\/edges\/edge\/destination$/, :string],
   [/^\/pingus-worldmap\/graph\/edges\/edge\/positions$/, :section],
   [/^\/pingus-worldmap\/graph\/edges\/edge\/positions\/position$/, :vector],
   [/^\/pingus-worldmap\/objects$/, :section],
  ]

$typespec_level = 
  [
   [/^\/pingus-level$/, :section],
   [/^\/pingus-level\/version$/, :integer],
   [/^\/pingus-level\/head$/, :section],
   [/^\/pingus-level\/head\/levelname$/, :string],
   [/^\/pingus-level\/head\/description$/, :string],
   [/^\/pingus-level\/head\/author$/, :string],
   [/^\/pingus-level\/head\/number-of-pingus$/, :integer],
   [/^\/pingus-level\/head\/number-to-save$/,  :integer],
   [/^\/pingus-level\/head\/time$/,  :integer],
   [/^\/pingus-level\/head\/difficulty$/,  :integer],
   [/^\/pingus-level\/head\/playable$/,  :integer],
   [/^\/pingus-level\/head\/comment$/,  :string],
   [/^\/pingus-level\/head\/music$/,  :string],
   [/^\/pingus-level\/head\/actions$/,  :section],
   [/^\/pingus-level\/head\/actions\/[a-z]+$/,  :integer],
   [/^\/pingus-level\/head\/levelsize$/,  :size],

   [/^\/pingus-level\/objects$/,  :section],

   [/^\/pingus-level\/objects\/surface-background$/,  :section],
   [/^\/pingus-level\/objects\/surface-background\/alpha$/,  :integer],
   [/^\/pingus-level\/objects\/surface-background\/red$/,  :integer],
   [/^\/pingus-level\/objects\/surface-background\/green$/,  :integer],
   [/^\/pingus-level\/objects\/surface-background\/blue$/,  :integer],
   [/^\/pingus-level\/objects\/surface-background\/scroll-x$/,  :float],
   [/^\/pingus-level\/objects\/surface-background\/scroll-y$/,  :float],
   [/^\/pingus-level\/objects\/surface-background\/para-x$/,  :float],
   [/^\/pingus-level\/objects\/surface-background\/para-y$/,  :float],
   [/^\/pingus-level\/objects\/surface-background\/stretch-x$/,  :integer],
   [/^\/pingus-level\/objects\/surface-background\/stretch-y$/,  :integer],
   [/^\/pingus-level\/objects\/surface-background\/keep-aspect$/,  :integer],

   [/^\/pingus-level\/objects\/conveyorbelt$/, :section],
   [/^\/pingus-level\/objects\/conveyorbelt\/width$/, :integer],
   [/^\/pingus-level\/objects\/conveyorbelt\/speed$/, :integer],

   [/^\/pingus-level\/objects\/entrance$/, :section],
   [/^\/pingus-level\/objects\/entrance\/type$/, :string],
   [/^\/pingus-level\/objects\/entrance\/direction$/, :string],
   [/^\/pingus-level\/objects\/entrance\/release-rate$/, :integer],
   [/^\/pingus-level\/objects\/entrance\/owner-id$/, :integer],

   [/^\/pingus-level\/objects\/exit$/, :section],
   [/^\/pingus-level\/objects\/exit\/owner-id$/, :integer],

   [/^\/pingus-level\/objects\/groundpiece$/, :section],
   [/^\/pingus-level\/objects\/groundpiece\/type$/, :string],

   [/^\/pingus-level\/objects\/guillotine$/, :section],
   [/^\/pingus-level\/objects\/hammer$/, :section],

   [/^\/pingus-level\/objects\/hotspot$/, :section],
   [/^\/pingus-level\/objects\/hotspot\/parallax$/, :integer],
   [/^\/pingus-level\/objects\/hotspot\/speed$/, :integer],

   [/^\/pingus-level\/objects\/iceblock$/, :section],
   [/^\/pingus-level\/objects\/iceblock\/width$/, :integer],

   [/^\/pingus-level\/objects\/infobox$/, :section],
   [/^\/pingus-level\/objects\/infobox\/info-text$/, :string],

   [/^\/pingus-level\/objects\/laser_exit$/, :section],

   [/^\/pingus-level\/objects\/liquid$/, :section],
   [/^\/pingus-level\/objects\/liquid\/width$/, :integer],
   [/^\/pingus-level\/objects\/liquid\/speed$/, :integer],

   [/^\/pingus-level\/objects\/rain-generator$/, :section],
   [/^\/pingus-level\/objects\/smasher$/, :section],
   [/^\/pingus-level\/objects\/snow-generator$/, :section],
   [/^\/pingus-level\/objects\/solidcolor-background$/, :section],
   [/^\/pingus-level\/objects\/spike$/, :section],

   [/^\/pingus-level\/objects\/switchdoor$/, :section],
   [/^\/pingus-level\/objects\/switchdoor\/switch$/, :section],
   [/^\/pingus-level\/objects\/switchdoor\/door$/, :section],
   [/^\/pingus-level\/objects\/switchdoor\/door\/height$/, :integer],

   [/^\/pingus-level\/objects\/teleporter$/, :section],
   [/^\/pingus-level\/objects\/teleporter\/target$/, :section],

]

$typespec_generic =
  [
   [/color$/, :color],

   [/position$/, :vector],

   [/surface$/, :section],
   [/surface\/image$/, :string],
   [/surface\/modifer$/, :string],
   [/surface\/modifier$/, :string],
   [/surface\/auto-uncover$/, :integer],
  ]

$typespec = $typespec_level + $typespec_generic

def get_type(section)
  $typespec.each{|pair|
    if section.match(pair[0]) then
      return pair[1]
    end
  }
  return :unknown
end

def line_breaker(str)
  lines = []
  line = ""
  word = ""

  str.each_byte{|c|
    word <<= c
    
    if c == ?\  then
      line += word
      word = ""

      if line.length > 72 then
        lines.push(line)
        line = ""
      end
    end
  }

  line += word
  if not line.empty? then
    lines.push(line)
  end
  return lines
end

def xml2array(section, indent, el)
  if el.is_a?(REXML::Text) then
    # puts section #, " -> ", $typespec[section], "\n"
    case get_type(section)
    when :section 
      # indention white space, ignore it
    when :integer
      print el.value.to_i
    else
      if section != ""
        puts "unknown: section: #{section} #{el.value}"
        puts el.inspect
        exit 1
      end
    end
    
  elsif el.is_a?(REXML::Element)
    case get_type("#{section}/#{el.name}")
    when :section 
      if el.children.length == 0 then
        print "#{indent}(#{el.name} )"
      else
        puts "#{indent}(#{el.name} "
        el.children.each{|child|
          xml2array("#{section}/#{el.name}", "#{indent}  ", child)
        }
        print ")"
      end
    when :string
      print "#{indent}(#{el.name} "
      el.children.each{|child|
        line_breaker(child.value).each_with_index{|line,idx|
          if idx == 0 then
            print "\"#{line}\""
          else
            print "\n#{indent}  #{" " * el.name.length}\"#{line}\""
          end
        }
      }
      print ")"
    when :integer
      print "#{indent}(#{el.name} "
      el.children.each{|child|
        print "#{child.value.to_i}"
      }
      print ")"
    when :float
      print "#{indent}(#{el.name} "
      el.children.each{|child|
        print "#{child.value.to_f}"
      }
      print ")"
    when :vector
      print "#{indent}(#{el.name} "
      print el.elements["x"][0].value
      print " "
      print el.elements["y"][0].value
      print " "
      print el.elements["z"][0].value
      print ")"

    when :color
      print "#{indent}(#{el.name} "
      print el.elements["red"][0].value
      print " "
      print el.elements["green"][0].value
      print " "
      print el.elements["blue"][0].value
      print " "
      print el.elements["alpha"][0].value
      print ")"

    when :size
      print "#{indent}(#{el.name} "
      print el.elements["width"][0].value
      print " "
      print el.elements["height"][0].value
      print ")"

    else
      puts "#{indent}(#{el.name} "
      el.children.each{|child|
        xml2array("#{section}/#{el.name}", "#{indent}  ", child)
      }
      print "#{indent} )"
    end
    if el.next_element then
      puts ""
    end
  elsif el.is_a?(REXML::Comment)
  elsif el.is_a?(REXML::XMLDecl)
  else
    $stderr.puts "Error, unknown element #{el.class}"
  end
end

ARGV.each{|arg|
  i = 0
  dir = File.dirname(arg)
  doc = REXML::Document.new(File.new(arg))
  puts ";; generated by xml2sexpr.rb convert script from '#{arg}'"
  doc.children.each{ |el|
    xml2array("", "", el)
  }
  puts "\n;; EOF ;;"
}

# EOF #
