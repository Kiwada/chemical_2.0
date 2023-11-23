class periodic_table{
  periodic_table._();

  static final periodic_table_instance = periodic_table._();

  factory periodic_table(){
    return periodic_table_instance;
  }
}