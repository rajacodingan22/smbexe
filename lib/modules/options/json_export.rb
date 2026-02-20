require 'json'
require 'utils'

class JSON_Export < Poet
  self.mod_name = "Export State to JSON"
  self.description = "Export the current smbexec state and logs to a JSON file."
  self.title = 'JSON Export Utility'

  def initialize
    t = Time.now
    @log = Menu.opts[:log]
    
    puts "\n#{self.class.description}"
    
    export_data = {
      "timestamp" => t.iso8601,
      "config" => Menu.opts,
      "hosts" => Menu.opts[:hosts],
      "credentials" => Menu.opts[:creds],
      "domain" => Menu.opts[:domain]
    }

    # Try to include any log files found in the current log directory
    log_files = Dir.glob("#{@log}/*.txt")
    export_data["logs"] = {}
    
    log_files.each do |file|
      name = File.basename(file)
      begin
        export_data["logs"][name] = File.read(file)
      rescue => e
        export_data["logs"][name] = "Error reading file: #{e}"
      end
    end

    json_output = JSON.pretty_generate(export_data)
    filename = "smbexec_export_#{t.strftime('%Y%m%d_%H%M%S')}.json"
    
    begin
      File.open("#{@log}/#{filename}", 'w') { |f| f.write(json_output) }
      print_good("State and logs exported to: #{@log}/#{filename}")
    rescue => e
      print_bad("Failed to export JSON: #{e}")
    end

    puts "\nPress enter to return to Options Menu"
    gets
  end
end
