function limit(field, max) {

  if (field.value.length > max) {
    field.value = field.value.substring(0, max);
  }
  
}