require "base64"
require "http/client"
require "json"
require "uri"
require "myhtml"

response = HTTP::Client.get "http://pastebin.com/raw/KzwWFYJL"
txt = response.body.lines.first 
/START:(.+):END/.match(txt)  
b64 = $1 ## weird special variables to refer to capture groups
json = Base64.decode_string(b64)
obj = JSON.parse(json)
quote = obj["msg"].as_s
resp2 = HTTP::Client.get "https://en.wikiquote.org/w/index.php?search=" + URI.escape(quote)
/<a.*href="([^"]+)"[^>]*data-serp-pos="0".*>/.match(resp2.body)
page_uri = $1

resp3 = HTTP::Client.get "https://en.wikiquote.org" + page_uri
myhtml = Myhtml::Parser.new(resp3.body)

quote = quote.downcase.gsub(/[.,_\-;:'"()]+/, "")
myhtml.nodes(:li).each do |node|
  if node.inner_text.downcase.gsub(/[.,_\-;:'"()]+/, "").starts_with?(quote)
    nested_ul = node.scope.nodes(:ul).first
    puts nested_ul.scope.nodes(:li).first.scope.nodes(:a).first.attribute_by("title")
  end
end


