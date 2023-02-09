import 'package:flutter/material.dart';

class DoctorProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Center(
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/user_4.png')),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              'CUI-Doctor',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Center(
            child: Text(
              '03037323839',
              style: TextStyle(fontSize: 15),
            ),
          ),
          // Text(
          //   'Email: fazalowais0@gmail.com',
          //   style: TextStyle(fontSize: 15),
          // ),
          // Text(
          //   'Address: None,MalaKand,Rawalpindi',
          //   style: TextStyle(fontSize: 15),
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.021,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.02),
            child: Text(
              'Name',
              style: TextStyle(fontSize: 15),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.017),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.009)),
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.030),
                child: TextField(
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.021,
                  ),
                  // controller: _firstNameController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'First Name'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.021,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.02),
            child: Text(
              'Street Address',
              style: TextStyle(fontSize: 15),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.017),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.009)),
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.030),
                child: TextField(
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.021,
                  ),
                  // controller: _firstNameController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'First Name'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.021,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.02),
            child: Text(
              'District',
              style: TextStyle(fontSize: 15),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.017),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.009)),
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.030),
                child: TextField(
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.021,
                  ),
                  // controller: _firstNameController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'First Name'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.021,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.02),
            child: Text(
              'City',
              style: TextStyle(fontSize: 15),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.017),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.009)),
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.030),
                child: TextField(
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.021,
                  ),
                  // controller: _firstNameController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'First Name'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.021,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.02),
            child: Text(
              'Postal Code',
              style: TextStyle(fontSize: 15),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.017),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.009)),
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.030),
                child: TextField(
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.021,
                  ),
                  // controller: _firstNameController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'First Name'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.021,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.02),
            child: Text(
              'Birth Date',
              style: TextStyle(fontSize: 15),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.017),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.009)),
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.030),
                child: TextField(
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.021,
                  ),
                  // controller: _firstNameController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'First Name'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.021,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.02),
            child: Text(
              'Gender',
              style: TextStyle(fontSize: 15),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.017),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.009)),
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.030),
                child: TextField(
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.021,
                  ),
                  // controller: _firstNameController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'First Name'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.021,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.02),
            child: Text(
              'Martial Status',
              style: TextStyle(fontSize: 15),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.017),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.009)),
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.030),
                child: TextField(
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.021,
                  ),
                  // controller: _firstNameController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'First Name'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.021,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.02),
            child: Text(
              'Specialization',
              style: TextStyle(fontSize: 15),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.017),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.height * 0.009)),
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.height * 0.030),
                child: TextField(
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.021,
                  ),
                  // controller: _firstNameController,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'First Name'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.021,
          ),

          GestureDetector(
            // onTap: signup,
            // signup,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height * 0.079),
              child: Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.020),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(29, 191, 193, 1),
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * 0.015)),
                child: Center(
                  child: Text(
                    "update",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * 0.021,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.021,
          ),
        ],
      )),
    );
  }
}
