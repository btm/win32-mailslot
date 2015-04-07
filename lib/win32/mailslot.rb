require_relative 'mailslot/constants'
require_relative 'mailslot/structs'
require_relative 'mailslot/functions'

module Win32
  class Mailslot
    include Windows::Mailslot::Constants
    include Windows::Mailslot::Structs
    include Windows::Mailslot::Functions

    def initialize(name, max_size = 0, max_time = MAILSLOT_WAIT_FOREVER, inherit = true)
      security = SECURITY_ATTRIBUTES.new
      security[:bInheritHandle] = inherit

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

    def mainloop
      while true
      end
    end
  end
end

if $0 == __FILE__
  m = Win32::Mailslot.new('test')
  m.close
end