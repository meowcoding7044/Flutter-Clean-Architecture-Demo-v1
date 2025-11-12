
import 'package:first_flutter_v1/core/utils/enums.dart';

class ApiResponse<T>{
  Status? status;
  T? data;
  String? message;

  ApiResponse({this.status, this.data, this.message});

  ApiResponse.success(this.data){
    this.status = Status.completed;
  }

  ApiResponse.error(this.message){
    this.status = Status.error;
  }

  ApiResponse.loading(){
    this.status = Status.loading;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Status : $status,\n Data : $data, \nMessage : $message";
  }
}
