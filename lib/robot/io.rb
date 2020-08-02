require 'readline'

module Robot
  # Encapsulating the STDIN/STDOUT operations for the Robot
  # This class could be replaced to use different IO source
  IO = Struct.new(:debug) do
    def read
      Readline.readline('> ', true)
    end

    def write(success: true, output: nil)
      puts output if success && !output.nil?
      puts "DEBUG: #{output}" if debug && !success
    end

    def error(exception)
      puts "ERROR: #{exception.message}\n#{exception.backtrace}" if debug
    end
  end
end
