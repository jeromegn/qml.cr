module QML
  class MetaClass
    @@registry = {} of Pointer(LibQML::ClientClass) => QML::ClientClass.class

    def initialize(@client_class : QML::ClientClass.class, @name : String)
      @pointer = LibQML.metaclass_new(@client_class, @name, LibQML::ClientCallbacks.new(
        new_object: ->(
          client_class : LibQML::ClientClass*,
          signal_emitter : LibQML::SignalEmitter*
        ) {
          puts "new_object", @@registry[client_class], signal_emitter
          obj = p(@@registry[client_class].new)
          obj.to_unsafe
        },
        delete_object: ->(
          client_object : LibQML::ClientObject*,
        ) {
          puts "delete_object", client_object
        },
        call_method: ->(
          engine : LibQML::Engine*,
          client_object : LibQML::ClientObject*,
          str : UInt8*,
          num : Int32,
          val : LibQML::Value**
        ) {
          puts "call_method", engine, client_object, str, num, val
          LibQML.value_new_undefined()
        },
        get_property: ->(
          engine : LibQML::Engine*,
          client_object : LibQML::ClientObject*,
          name : UInt8*
        ) {
          puts "get_property", engine, client_object, name
          LibQML.value_new_undefined() # TODO
        },
        set_property: ->(
          engine : LibQML::Engine*,
          client_object : LibQML::ClientObject*,
          name : UInt8*,
          val : LibQML::Value*
        ) {
          puts "set_property", engine, client_object, name, val
        }
      ))
      @@registry[@client_class.to_unsafe] = @client_class
    end

    def register
      LibQML.metaclass_register(self, @name, 0, 0, @name)
      puts "registered metaclass #{self} #{@name}"
    end

    def add_signal(name : String, args : Array(String))
      LibQML.metaclass_add_signal(self, name, args.size, args.map(&.to_unsafe))
      puts "registered signal #{@client_class} ~ #{name}"
    end

    def add_property(name, signal_name)
      LibQML.metaclass_add_property(self, name.to_s, signal_name)
      puts "registered property #{@client_class}##{name}"
    end

    def to_unsafe
      @pointer
    end

    def finalize
      LibQML.metaclass_release(self)
    end

    def self.registry
      @@registry
    end
  end
end
