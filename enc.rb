# ffmpeg -i ..\asik.mp4 -profile:v baseline -level 3.0 -start_number 0 -hls_list_size 0 -f hls asik.m3u8

if (ARGV.length == 0) then
	puts "Please specify m3u8 file"
	exit
end

#puts ARGV[0]+" - "+File.basename(ARGV[0])+" - "+File.dirname(ARGV[0])
#return

#File.basename(ARGV[0])

if (!(ARGV[0].end_with? "m3u8")) then
	puts "Parameter should be a m3u8 file"
	exit
end

def enc(source,target)
	   puts "Encrypting #{source} -> #{target}"

   file = File.new(source,"r")
   fileW = File.new(target,"wb")
   file.each_byte do |ch|
    x = ch ^ 144
    fileW.write(x.chr)
   end
end

m3u8=ARGV[0]

_m3u8=File.dirname(m3u8)+"/_"+File.basename(m3u8)

File.open(_m3u8,'w') do |f_m3u8|
	File.readlines(m3u8).each do |l|
		line = l.gsub(/\n/,'').gsub(/\r/,'')

#		puts "L:"+line

		if (line.end_with?(".ts") || line.end_with?(".TS")) then
			enc(File.dirname(m3u8)+"/"+line, File.dirname(m3u8)+"/_"+line)
			f_m3u8.puts "_"+line
		else
			f_m3u8.puts line
		end

	end
end

#// Orj: 01000111 New: 11010111 -- 10010000