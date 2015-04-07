require 'ffi'

module Windows
  module Mailslot
    module Structs
      extend FFI::Library
      typedef :ulong, :dword

      class SECURITY_ATTRIBUTES < FFI::Struct
        layout(:nLength, :dword, :lpSecurityDescriptor, :pointer, :bInheritHandle, :bool)
      end
    end
  end
end