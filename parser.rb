require 'csv'
require 'json'
require 'set'
require 'uri'
require 'net/http'

licenses = Set.new

if File.exist?('license-finder/dependencies/npm_deps.json')
	file_1 = File.read('license-finder/dependencies/npm_deps.json')
	hash_1 = JSON.parse(file_1)
	unless hash_1.empty?
		hash_1.each_pair do |k, d|
			nv = k.split('@')
			if nv.count == 3
				name = nv[1]
                name = name.delete("@")
				version = nv[2]
			else
				name = nv[0]
						version = nv[1]
			end
			license = d["licenses"]
			license = license.sub("MIT*", "MIT")
			url = d["repository"].to_s
			url = url.sub("git@", "https://").sub(".com:", ".com/")
			url = url.sub(".git", "").sub("git://", "https://").sub("git+", "")
			temp = {"name" => name, "version" => version, "license" => license, "url" => url}
			licenses << temp
		end
	end
end

if File.exist?('license-finder/dependencies/yarn_deps.json')
	file_2 = File.read('license-finder/dependencies/yarn_deps.json')
	hash_2 = JSON.parse(file_2)
	hash_2 = hash_2["data"]["body"]
	unless hash_2.empty?
		hash_2.each do |x|
			name = x[0]
            name = name.delete("@")
			version = x[1]
			license = x[2]
			license = license.sub("MIT*", "MIT")
			url = x[3]
			url = url.sub("git@", "https://").sub(".com:", ".com/")
			url = url.sub(".git", "").sub("git://", "https://").sub("git+", "")
			temp = {"name" => name, "version" => version, "license" => license, "url" => url}
			licenses << temp
		end
	end

end

if File.exist?('license-finder/dependencies/gem_deps.json')
	file_3 = File.read('license-finder/dependencies/gem_deps.json')
	hash_3 = JSON.parse(file_3)
	hash_3 = hash_3["dependencies"]
	unless hash_3.empty?
		hash_3.each do |x|
			name = x["name"]
			version = x["version"]
			license = x["license"]
			license = license.sub("MIT*", "MIT")
			url = x["homepage_url"]
			url = url.sub("git@", "https://").sub(".com:", ".com/")
			url = url.sub(".git", "").sub("git://", "https://").sub("git+", "")
			temp = {"name" => name, "version" => version, "license" => license, "url" => url}
			licenses << temp
		end
	end
end

if File.exist?('license-finder/dependencies/python_deps.json')
	file_4 = File.read('license-finder/dependencies/python_deps.json')
	hash_4 = JSON.parse(file_4)
	unless hash_4.empty?
		hash_4.each do |x|
			name = x["Name"]
			version = x["Version"]
			license = x["License"]
			license = license.sub("MIT*", "MIT").sub("MIT License", "MIT").slice(0, 30).gsub("\n", " ")
			url = x["URL"]
			url = url.sub("git@", "https://").sub(".com:", ".com/")
			url = url.sub(".git", "").sub("git://", "https://").sub("git+", "")
			temp = {"name" => name, "version" => version, "license" => license, "url" => url}
			licenses << temp
		end
	end
end


def read_data
    if File.exist?("syft.json")
        data = JSON.parse(File.read("syft.json"))["packages"]
    end
end   

def parse_packages(licenses)
    output = []
    data = read_data
    data.each do |d|
        name = d["name"]
        name = name.delete("@")
        version = d["versionInfo"]
        license = d["licenseDeclared"]
        source = d["sourceInfo"]
        l = licenses.select {|l| l["name"] == "#{name}"}
        unless l.empty?
            url = l[0]["url"]
            if url.include? "https://github.com/ezcater"
                license = "EZCATER REPO - UNLICENSED"
            end
            if license == "NOASSERTION"
                if l[0]["license"] != "UNKOWN"
                    license = l[0]["license"]
                end
            end
        end
        
        if license == "NOASSERTION" and source.include? 'Gemfile.lock'
            out = `./license-finder/try-ruby.sh #{name} #{url}`
            puts out
        end

        hash = {"name" => "#{name}", "version" => "#{version}", "license" => "#{license}", "url" => "#{url}", "source" => "#{source}"}
        output << hash
    end
    return output
end



output = parse_packages(licenses)

headers = ["Name", "Version", "License", "Url", "Source"]
CSV.open("licenses.csv", "w") do |csv|
	csv << headers
	output.each do |l|
		csv << l.values
	end
end
