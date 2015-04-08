require_relative 'mailslot/constants'
require_relative 'mailslot/structs'
require_relative 'mailslot/functions'

module Win32
  class Mailslot
    include Windows::Mailslot::Constants
    include Windows::Mailslot::Structs
    include Windows::Mailslot::Functions

    # The name of the mailslot. Note that "//./mailslot/" is
    # automatically prepended.
    attr_reader :name

    # The maximum size of a single message that can be written to the mailslot,
    # in bytes. The default is 0 (any size).
    attr_reader :max_size

    # The time a read operation can wait for a message to be written to the
    # mailslot before a time-out occurs, in milliseconds.
    attr_reader :max_time

    # Determines whether the returned handle can be inherited by child
    # processes. The default is true.
    attr_reader :inherit

    # The raw handle returned by the CreateMailSlot function
    attr_reader :handle

    # Returns a new Mailslot object.
    #
    # The +name+ argument is mandatory. It is automatically prepended
    # with "//./mailslot/" so you shouldn't add that yourself.
    #
    # The +max_size+ defaults to 0, meaning the maximum size of a single
    # message is unlimited by default.
    #
    # The +max_time+ argument sets the read timeout in milliseconds, which
    # defaults to forever.
    #
    # The +inherit+ argument sets whether or not child processes can inherit
    # the handle returned by Mailslot#create method. The default is true.
    #
    # Note that this does not actually create the mailslot. This only sets
    # parameters to be used later as needed. To create the mailslot call the
    # Mailslot#create method.
    #
    def initialize(name, max_size = 0, max_time = MAILSLOT_WAIT_FOREVER, inherit = true)
      @security = SECURITY_ATTRIBUTES.new
      @security[:bInheritHandle] = inherit

      @name = "\\\\.\\mailslot\\" << name

      @max_size = max_size
      @max_time = max_time
      @inherit  = inherit
      @handle   = nil
    end

    # Creates a mailslot with the parameters given to the constructor.
    #
    # Returns the raw handle.
    #
    def create
      @handle = CreateMailslot(@name, @max_size, @max_time, @security)

      if @handle == INVALID_HANDLE_VALUE
        raise SystemCallError.new('CreateMailSlot', FFI.errno)
      end

      @handle
    end

    # Close a mailslot created with the Mailslot#create method.
    def close
      CloseHandle(@handle) if @handle
    end

    # Send a message to the mailslot named in the constructor.
    def send(msg)
    end

    # Receive a mailslot message.
    def recv
    end

    # Returns a MailslotInfo struct containing message size, next size, message
    # count and timeout values for the given handle, or the handle created by
    # the constructor if no argument is specified.
    #
    def get_info
    end
  end
end

if $0 == __FILE__
  m = Win32::Mailslot.new('test')
  m.close
end
