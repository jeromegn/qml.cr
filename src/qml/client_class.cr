module QML
  @@classes_map = {} of Pointer(LibQML::ClientClass) => ClientClass.class

  def self.classes_map
    @@classes_map
  end

  abstract class ClientClass
    @@pointer = uninitialized Pointer(LibQML::ClientClass)
    @pointer : Pointer(LibQML::ClientObject)?
    @@client_objects = Hash(Pointer(LibQML::ClientObject), self).new
    
    macro inherited
      @@metaclass = QML::MetaClass.new(self, self.name)
    end
    
    def self.register_to_qml
      @@metaclass.register
    end

    def self.metaclass
      @@metaclass
    end

    def to_unsafe
      @pointer ||= Pointer(LibQML::ClientObject).malloc(1)
      @@client_objects[@pointer.not_nil!] ||= self
      @pointer.not_nil!
    end

    def self.qml_property(name)
      metaclass.add_signal("#{name}Changed", ["value"])
      metaclass.add_property(name.to_s, "#{name}Changed")
    end

    def self.to_unsafe
      @@pointer
    end
  end
end