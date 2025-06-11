import 'dart:io';
import 'dart:math';

import 'package:e_ride_up/core/constants/app_colors.dart';
import 'package:e_ride_up/core/constants/assets.dart';
import 'package:e_ride_up/core/constants/general.dart';
import 'package:e_ride_up/core/services/shared_preference_service.dart';
import 'package:e_ride_up/core/widgets/custom_drawer.dart';
import 'package:e_ride_up/core/widgets/custom_text.dart';
import 'package:e_ride_up/models/DetailsUserModel.dart';
import 'package:e_ride_up/models/LoginOtpResponse.dart';
import 'package:e_ride_up/providers/custom_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? _imageUrl;
  Customer? _user;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final provider = Provider.of<CustomProvider>(context, listen: false);
      Customer? customer=   await SharedPreferenceService.getUserDetails();
      await provider.getDetailsUser(customer?.email??"", context);
      _user=provider.detailsUserModel?.customer;
      printLog(_user?.toJson());

      if (_user != null) {
        _nameController.text = _user?.name ?? '';
        _phoneController.text = _user?.phone ?? '';
        _emailController.text = _user?.email ?? '';
        _addressController.text = _user?.address ?? '';
        _imageUrl = _user?.profileImage??"";

      }


  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _onSave() async {
    if (_formKey.currentState!.validate()) {
      final customer = Customer(

        id: _user?.id,
        name: _nameController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        address: _addressController.text,
        city: _user?.city,
        state: _user?.state,
        country: _user?.country,
        postalCode: _user?.postalCode,
        dateOfBirth: _user?.dateOfBirth,
        gender: _user?.gender,
        profileImage: _imageUrl
      );

      final provider = Provider.of<CustomProvider>(context, listen: false);
      await provider.updateCustomerDetails(customer, context);
      // if(provider.updateCustomerModel?.message!=null && provider.updateCustomerModel?.status==true){
      //   // final updatedUser = await SharedPreferenceService.getUserDetails();
      //   // setState(() {
      //   //   _user = updatedUser;
      //   //   _imageUrl = _user?.profileImage;
      //   // });
      //
      // }


    }
  }

  File? _selectedImageFile;
  final ImagePicker _picker = ImagePicker();




  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera),
              title: Text("Camera"),
              onTap: () async {
                Navigator.of(context).pop();
                final picked = await _picker.pickImage(source: ImageSource.camera, imageQuality: 75);
                if (picked != null) {
                  setState(() {
                    _selectedImageFile = File(picked.path);
                    _imageUrl=picked.path;
                  });
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text("Gallery"),
              onTap: () async {
                Navigator.of(context).pop();
                final picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
                if (picked != null) {
                  setState(() {
                    _selectedImageFile = File(picked.path);
                    _imageUrl=picked.path;
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:CustomDrawer(),
      backgroundColor: Colors.white,
      body: Consumer<CustomProvider>(
        builder: (context, value, child) =>
         Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(MyAssets.profileBackground),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 16,
                            left: 16,
                            child: Builder(
                              builder: (context) => IconButton(
                                icon: Icon(Icons.menu, color: Colors.white),
                                onPressed: () => Scaffold.of(context).openDrawer(),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 130,
                            left: MediaQuery.of(context).size.width / 2 - 45,
                            child: GestureDetector(
                              onTap: _showImagePickerOptions,
                              child: CircleAvatar(
                                radius: 45,
                                backgroundColor: Colors.white,
                                backgroundImage: _selectedImageFile != null
                                    ? FileImage(_selectedImageFile!)
                                    : (_imageUrl != null && _imageUrl!.startsWith('http')
                                    ? NetworkImage(_imageUrl!)
                                    : null),
                                child: (_selectedImageFile == null &&
                                    (_imageUrl == null || _imageUrl!.isEmpty || !_imageUrl!.startsWith('http')))
                                    ? Icon(Icons.person, color: Colors.deepOrange, size: 50)
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 60),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            ProfileCard(
                              title: "Name",
                              controller: _nameController,
                              validator: (value) =>
                              value!.isEmpty ? "Please enter your name" : null,
                            ),
                            ProfileCard(
                              title: "Phone Number",
                              controller: _phoneController,
                              validator: (value) =>
                              value!.isEmpty ? "Enter phone number" : null,
                            ),
                            ProfileCard(
                              enabled: false,
                              title: "E-mail",
                              controller: _emailController,
                              validator: (value) => value!.isEmpty || !value.contains('@')
                                  ? "Enter valid email"
                                  : null,
                            ),
                            ProfileCard(
                              title: "Address",
                              controller: _addressController,
                              validator: (value) =>
                              value!.isEmpty ? "Please enter address" : null,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),

                      Consumer<CustomProvider>(
                        builder: (context, provider, child) {
                          return ElevatedButton.icon(
                            onPressed: provider.isUpdateProfileLoading ? null : _onSave,
                            icon: provider.isUpdateProfileLoading
                                ? SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                                : Icon(Icons.edit_note_outlined, color: AppColor.white),
                            label: CustomText(
                              text: provider.isUpdateProfileLoading ? "Saving..." : "Edit Profile",
                              color: AppColor.white,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            if (value.isDetailsUserLoading)
              Container(
                color: Colors.black45,
                child:  Center(
                  child: CircularProgressIndicator(
                    color: AppColor.appPrimaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String title;
  final bool? enabled;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const ProfileCard({
    required this.title,
    required this.controller,
    required this.validator,
    this.enabled
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.white,
      elevation: 4,
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
        child: TextFormField(
          enabled:enabled??true ,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            labelText: title,
            border: InputBorder.none,
            suffixIcon: Icon(Icons.edit_note_outlined, color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
