# Removes the .field_with_error <div> that is automatically wrapped around form elements
ActionView::Base.field_error_proc = proc { |input, instance| input }