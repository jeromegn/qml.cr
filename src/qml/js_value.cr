module QML
  class JSValue
    def initialize(@pointer : Pointer(LibQML::Value))
    end

    def to_unsafe
      @pointer
    end

    def finalize
      LibQML.value_release(self)
    end
  end
end
