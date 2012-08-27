#!/usr/bin/env ruby


#This script takes a shell script, breaks it down into js array of js strings and replaces a token 
# in a Cloud Formation Template with the script (along with necessary Join and Base64 Encode). 


inScript = ARGV[0]        or  abort "Missing arguments! usage : user_data.rb <script-file> <cloud_formation_file> <userdata_token> <?out-file>"
cfFile  = ARGV[1]     or  abort "Missing arguments! usage : user_data.rb <script-file> <cloud_formation_file> <userdata_token> <?out-file>"
userDataToken  = ARGV[2]  or  abort "Missing arguments! usage : user_data.rb <script-file> <cloud_formation_file> <userdata_token> <?out-file>"
outFile = ARGV[3]
USER_DATA_BEGIN = '{ "Fn::Base64" : { "Fn::Join" : ["", [' << "\n"

USER_DATA_END = ']]}}' << "\n"

def outTo(outFile)
  return STDOUT if outFile.nil?
  return out = File.open(outFile,'w')
end 

def jsify(script) 
    lines = []
    File.open(script, 'r') do |f1| 
       f1.each  do |line| 
         lines << jsstringify(line.chop!) 
       end
    end
    lines.last.chop! #remove the last comma
    return lines.join("\n")
end
    
def jsstringify(line) 
     '"' <<  line << '\n' << '"' << ','
end
def replaceUserDataToken(cfFile, token, newValue) 
  fileText = File.read(cfFile)
  fileText.gsub(/#{Regexp.escape(token)}/,newValue)
end


out = outTo(outFile)
script = jsify(inScript)
user_data = USER_DATA_BEGIN << script << USER_DATA_END

out.puts replaceUserDataToken(cfFile, userDataToken,user_data)

