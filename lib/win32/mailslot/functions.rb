require 'ffi'

module Windows
  module Mailslot
    module Functions
      extend FFI::Library

      ffi_lib :kernel32

      typedef :uintptr_t, :handle
      typedef :ulong, :dword
      typedef :pointer, :ptr

      attach_function :CloseHandle, [:handle], :bool
      attach_function :CreateMailslot, :CreateMailslotA, [:string, :dword, :dword, :ptr], :handle
      attach_function :GetMailslotInfo, [:handle, :ptr, :ptr, :ptr, :ptr], :bool
      attach_function :ReadFile, [:handle, :buffer_out, :dword, :ptr, :ptr], :bool
      attach_function :SetMailslotInfo, [:handle, :dword], :bool
      attach_function :WriteFile, [:handle, :buffer_in, :dword, :ptr, :ptr], :bool
    end
  end
end
