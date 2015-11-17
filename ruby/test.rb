def replace(file_path, contents)
  file = File.open(file_path, 'r+')
  html = ''
  html += file.readline until file.eof?
  file.close
  html.gsub(/<!--start-->(.*)<!--end-->/im, contents)
end
paths = Dir['../js/*']
stuff = "<!--start-->\n"
paths.each do |i|
  stuff += "<script type='text/javascript' src='#{i[3..-1]}'></script>\n"
end
stuff += "<!--end-->\n"
IO.write('../index.html', File.open('../index.html') do |_f|
  replace('../index.html', stuff)
end
        )
        