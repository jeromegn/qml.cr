@[Link("qmlbind")]
lib LibQML
  type Application = Void*

  fun application_new = qmlbind_application_new(argc : Int32, argv : UInt8**) : Application*
  fun application_instance = qmlbind_application_instance() : Application*
  fun application_release = qmlbind_application_release(self : Application*)
  fun application_exec = qmlbind_application_exec(self : Application*) : Int32
  fun application_exit = qmlbind_application_exit(returnCode : Int32)
  fun process_events = qmlbind_process_events()
  fun next_tick = qmlbind_next_tick(callback : Proc(Void*, Void), data : Void*)


  type Component = Void*

  fun component_new = qmlbind_component_new(engine : Engine*) : Component*
  fun component_release = qmlbind_component_release(self : Component*)
  fun component_load_path = qmlbind_component_load_path(self : Component*, path : UInt8*)
  fun component_load_url = qmlbind_component_load_url(self : Component*, url : UInt8*)
  fun component_set_data = qmlbind_component_set_data(self : Component*, data : UInt8*, path : UInt8*)
  fun component_get_error_string = qmlbind_component_get_error_string(self : Component*) : QMLBindString*
  fun component_create = qmlbind_component_create(self : Component*) : Value*


  type Engine = Void*

  fun engine_new = qmlbind_engine_new() : Engine*
  fun engine_release = qmlbind_engine_release(self : Engine*)
  fun engine_eval = qmlbind_engine_eval(self : Engine*, str : UInt8*, fileName : UInt8*, lineNumber : Int32) : Value*
  fun engine_get_global_object = qmlbind_engine_get_global_object(self : Engine*) : Value*
  fun engine_new_object = qmlbind_engine_new_object(self : Engine*) : Value*
  fun engine_new_array = qmlbind_engine_new_array(self : Engine*, length : Int32) : Value*
  fun engine_new_wrapper = qmlbind_engine_new_wrapper(self : Engine*, metaclass : Metaclass*, object : ClientObject*) : Value*
  fun engine_add_import_path = qmlbind_engine_add_import_path(self : Engine*, path : UInt8*)
  fun engine_collect_garbage = qmlbind_engine_collect_garbage(self : Engine*)


  type Iterator = Void*

  fun iterator_new = qmlbind_iterator_new(object : Value*) : Iterator*
  fun iterator_release = qmlbind_iterator_release(self : Iterator*)
  fun iterator_get_key = qmlbind_iterator_get_key(self : Iterator*) : QMLBindString*
  fun iterator_get_value = qmlbind_iterator_get_value(self : Iterator*) : Value*
  fun iterator_next = qmlbind_iterator_next(self : Iterator*)
  fun iterator_has_next = qmlbind_iterator_has_next(self : Iterator*) : Int32


  type Metaclass = Void*

  fun metaclass_new = qmlbind_metaclass_new(classObject : ClientClass*, className : UInt8*, callbacks : ClientCallbacks) : Metaclass*
  fun metaclass_release = qmlbind_metaclass_release(self : Metaclass*)
  fun metaclass_add_method = qmlbind_metaclass_add_method(self : Metaclass*, name : UInt8*, arity : Int32)
  fun metaclass_add_signal = qmlbind_metaclass_add_signal(self : Metaclass*, name : UInt8*, arity : Int32, params : UInt8**)
  fun metaclass_add_property = qmlbind_metaclass_add_property(self : Metaclass*, name : UInt8*, notifierSignal : UInt8*)
  fun metaclass_register = qmlbind_metaclass_register(self : Metaclass*, uri : UInt8*, versionMajor : Int32, versionMinor : Int32, qmlName : UInt8*)


  type Plugin = Void*

  fun plugin_new = qmlbind_plugin_new(filename : UInt8*) : Plugin*
  fun plugin_release = qmlbind_plugin_release(self : Plugin*)
  fun plugin_get_error_string = qmlbind_plugin_get_error_string(self : Plugin*) : QMLBindString*
  fun plugin_get_instance = qmlbind_plugin_get_instance(self : Plugin*, engine : Engine*) : Value*


  type ClientObject = Void*


  type ClientClass = Void*


  struct ClientCallbacks
    new_object : Proc(ClientClass*, SignalEmitter*, ClientObject*)
    delete_object : Proc(ClientObject*, Nil)
    call_method : Proc(Engine*, ClientObject*, UInt8*, Int32, Value**, Value*)
    get_property : Proc(Engine*, ClientObject*, UInt8*, Value*)
    set_property : Proc(Engine*, ClientObject*, UInt8*, Value*, Nil)
  end


  type SignalEmitter = Void*

  fun signal_emitter_new = qmlbind_signal_emitter_new(wrapper : Value*) : SignalEmitter*
  fun signal_emitter_emit = qmlbind_signal_emitter_emit(self : SignalEmitter*, signal_name : UInt8*, argc : Int32, argv : Value**)
  fun signal_emitter_get_engine = qmlbind_signal_emitter_get_engine(self : SignalEmitter*) : Engine*
  fun signal_emitter_release = qmlbind_signal_emitter_release(self : SignalEmitter*)


  type QMLBindString = Void*

  fun string_get_chars = qmlbind_string_get_chars(self : QMLBindString*) : UInt8*
  fun string_get_length = qmlbind_string_get_length(self : QMLBindString*) : Int32
  fun string_release = qmlbind_string_release(self : QMLBindString*)


  type Value = Void*

  fun value_new_undefined = qmlbind_value_new_undefined() : Value*
  fun value_new_null = qmlbind_value_new_null() : Value*
  fun value_release = qmlbind_value_release(self : Value*)
  fun value_clone = qmlbind_value_clone(other : Value*) : Value*
  fun value_is_equal = qmlbind_value_is_equal(value1 : Value*, value2 : Value*) : Int32
  fun value_is_identical = qmlbind_value_is_identical(value1: Value*, value2 : Value*) : Int32
  fun value_is_undefined = qmlbind_value_is_undefined(self : Value*) : Int32
  fun value_is_null = qmlbind_value_is_null(self : Value*) : Int32
  fun value_is_boolean = qmlbind_value_is_boolean(self : Value*) : Int32
  fun value_is_number = qmlbind_value_is_number(self : Value*) : Int32
  fun value_is_string = qmlbind_value_is_string(self : Value*) : Int32
  fun value_is_object = qmlbind_value_is_object(self : Value*) : Int32
  fun value_is_array = qmlbind_value_is_array(self : Value*) : Int32
  fun value_is_function = qmlbind_value_is_function(self : Value*) : Int32
  fun value_is_error = qmlbind_value_is_error(self : Value*) : Int32
  fun value_is_wrapper = qmlbind_value_is_wrapper(self : Value*) : Int32
  fun value_new_boolean = qmlbind_value_new_boolean(value : Int32) : Value*
  fun value_get_boolean = qmlbind_value_get_boolean(self : Value*) : Int32
  fun value_new_number = qmlbind_value_new_number(value : Float64) : Value*
  fun value_get_number = qmlbind_value_get_number(self : Value*) : Float64
  fun value_new_string = qmlbind_value_new_string(length : Int32, value : UInt8*) : Value*
  fun value_new_string_cstr = qmlbind_value_new_string_cstr(value : UInt8*) : Value*
  fun value_get_string = qmlbind_value_get_string(self : Value*) : QMLBindString*
  fun value_get_property = qmlbind_value_get_property(self : Value*, key : UInt8*) : Value*
  fun value_set_property = qmlbind_value_set_property(self : Value*, key : UInt8*, value : Value*)
  fun value_delete_property = qmlbind_value_delete_property(self : Value*, key : UInt8*) : Int32
  fun value_has_property = qmlbind_value_has_property(self : Value*, key : UInt8*) : Int32
  fun value_has_own_property = qmlbind_value_has_own_property(self : Value*, key : UInt8*) : Int32
  fun value_get_prototype = qmlbind_value_get_prototype(self : Value*) : Value*
  fun value_set_prototype = qmlbind_value_set_prototype(self : Value*, proto : Value*)
  fun value_has_index = qmlbind_value_has_index(self : Value*, index : Int32) : Int32
  fun value_get_array_item = qmlbind_value_get_array_item(self : Value*, index : Int32) : Value*
  fun value_set_array_item = qmlbind_value_set_array_item(self : Value*, index : Int32, property : Value*)
  fun value_call = qmlbind_value_call(self : Value*, argv : Value**) : Value*
  fun value_call_constructor = qmlbind_value_call_constructor(function : Value*, argc : Int32, argv : Value**) : Value*
  fun value_call_with_instance = qmlbind_value_call_with_instance(self : Value*, instance : Value*, argc : Int32, argv : Value**) : Value*
  fun value_unwrap = qmlbind_value_unwrap(self : Value*) : ClientObject*
end
