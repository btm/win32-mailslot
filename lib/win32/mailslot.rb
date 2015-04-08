require_relative 'mailslot/constants'
require_relative 'mailslot/structs'
require_relative 'mailslot/functions'

module Win32
  class Mailslot
    include Windows::Mailslot::Constants
    include Windows::Mailslot::Structs
    include Windows::Mailslot::Functions

    # The name of the mailslot. Note that "//./mailslot/" is automatically prepended.
    attr_reader :name

    # The maximum size of a single message that can be written to the mailslot, in bytes. The default is 0 (any size).
    attr_reader :max_size

    # The time a read operation can wait for a message to be written to the mailslot before a time-out occurs, in milliseconds. 
    attr_reader :max_time

    # Determines whether the returned handle can be inherited by child processes. The default is true.
    attr_reader :inherit

    # The raw handle returned by the CreateMailSlot function
    attr_reader :handle

    def initialize(name, max_size = 0, max_time = MAILSLOT_WAIT_FOREVER, inherit = true)
      @security = SECURITY_ATTRIBUTES.new
      @security[:bInheritHandle] = inherit

      @name = "\\\\.\\mailslot\\" << name
      @max_size = max_size
      @max_time = max_time
      @inherit  = inherit

      @handle = CreateMailslot(@name, @max_size, @max_time, @security)

      if @handle == INVALID_HANDLE_VALUE
        raise SystemCallError.new('CreateMailSlot', FFI.errno)
      end
    end

    def close
      CloseHandle(@handle) if @handle
    end

    # Returns a MailslotInfo struct containing message size, next size, message
    # count and timeout values for the given handle, or the handle created by
    # the constructor if no argument is specified.
    #
    def get_info(handle = @handle)
      
    end
  end
end

if $0 == __FILE__
  m = Win32::Mailslot.new('test')
  m.close
end