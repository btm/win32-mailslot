require 'ffi'

module Win32
  class Mailslot
    module Functions
      extend FFI::Library

      ffi_lib :kernel32

      typedef :uintptr_t, :handle
      typedef :ulong, :dword

      attach_function :CloseHandle, [:handle], :bool
      attach_function :CreateMailslotA, [:string, :dword, :dword, :pointer], :handle
      attach_function :GetMailslotInfo, [:handle, :pointer, :pointer, :pointer, :pointer], :bool
      attach_function :SetMailslotInfo, [:handle, :dword], :bool
    end
  end
end
