require 'ffi'

module Windows
  module Mailslot
    module Constants
      INVALID_HANDLE_VALUE = (1 << FFI::Platform::ADDRESS_SIZE) - 1
      MAILSLOT_WAIT_FOREVER = -1
    end
  end
end
