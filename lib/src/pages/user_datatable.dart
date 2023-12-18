import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fdatatable/fdatatable.dart';
import 'package:flutter_dashboard/src/models/api/ListRequest.dart';
import 'package:flutter_dashboard/src/models/api/ListResponse.dart';
import 'package:flutter_dashboard/src/models/api/User.dart';
import 'package:flutter_dashboard/src/service/ApiService.dart';
import 'package:flutter_dashboard/src/service/UserService.dart';

class UserDatatable extends StatefulWidget{

  @override
  State createState() => _UserState();
}

class _UserState extends State<UserDatatable>{
  final UserService userService = UserService(apiUrl: BaseService.getHostAddress());
  final FDTController<User> fdtController = FDTController();
  @override
  void initState() {
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: FDT<User>(
          controller: fdtController,
          actionCallBack: (action) {
            print(action.key);
              switch(action.key){
                case "edit":
                  fdtController.editItem(action.index!);
                case "add":
                  fdtController.addItem(User.fromJson({}));
                case "formSave":
                  print(action.item!.toJson());
              }
          },
          columns: [
            FDTTextColumn(
                title: "id",
                key: "id",
                getter: (item) => item.id,
                setter: (item, value) {
                  item.id = value;
                  return true;
                },
                min: 24,
                max: 24,
                isFilter: false,
                readOnly: true
            ),
            FDTTextColumn(
                title: "First Name",
                key: "firstName",
                getter: (item) => item.firstName,
                setter: (item, value) {
                  item.firstName = value;
                  return true;
                },
                min: 3,
                max: 24,
            ),
            FDTTextColumn(
                title: "Last Name",
                key: "lastName",
                getter: (item) => item.lastName,
                setter: (item, value) {
                  item.lastName = value;
                  return true;
                },
                min: 3,
                max: 24,
            ),
            FDTTextColumn(
                title: "Email",
                key: "email",
                getter: (item) => item.email,
                setter: (item, value) {
                  item.email = value;
                  return true;
                },
                inputType: TextInputType.emailAddress,
                min: 10,
                max: 50,
            ),
            FDTTextColumn(
                title: "Password",
                key: "password",
                getter: (item) => item.password,
                setter: (item, value) {
                  item.password = value;
                  return true;
                },
                inputType: TextInputType.visiblePassword,
                min: 10,
                max: 50,
              visible: false
            ),
            FDTDropDownColumn<User, String>(
                title: "Role",
                key: "role",
                getter: (item) => item.role,
                setter: (item, value) {
                  item.role = value;
                  return true;
                },
                items: const [
                  DropdownMenuItem(
                    child: Text("admin"),
                    value: "admin",
                  ),
                  DropdownMenuItem(
                    child: Text("Super Admin"),
                    value: "SuperAdmin",
                  ),
                  DropdownMenuItem(
                    child: Text("Guest"),
                    value: "Guest",
                  )
                ]
            ),
            FDTCheckboxColumn(
                title: "Active",
                key: "active",
                getter: (item) => item.active,
                setter: (item, value) {
                  item.active = value;
                  return true;
                },
                required: true
            )
          ],
          fdtRequest: (requestModel) async {

            ListResponse<User> response = await userService.getList(ListRequest(
                page: requestModel.page,
              pageSize: requestModel.pageSize,
              filters: [],
            ));

            return FDTResponseModel(
              page: response.page,
              pageSize: response.pageSize,
              total: response.total,
              list: response.list
            );
          },
          title: Text("User List"),
          icon: Icon(Icons.list_alt_outlined),
          rowActions: [
            FAction(key: "edit", text: Text("Edit"), icon: Icon(Icons.edit),)
          ],
          topActions: [
            FAction(key: "add", text: Text("Add"), icon: Icon(Icons.add),)
          ],
        ),
      ),
    );
  }
}