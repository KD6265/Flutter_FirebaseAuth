import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Map<String, dynamic>? data;
  Future<Map<String, dynamic>> fetchData() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/users/1"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data'); // Handle API errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          data = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${data!['name']}'),
                Text('Username: ${data!['username']}'),
                Text('Email: ${data!['email']}'),
                const Text('Address:'),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Street: ${data!['address']['street']}'),
                      Text('Suite: ${data!['address']['suite']}'),
                      Text('City: ${data!['address']['city']}'),
                      Text('Zipcode: ${data!['address']['zipcode']}'),
                      const Text('Geo:'),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Lat: ${data!['address']['geo']['lat']}'),
                            Text('Lng: ${data!['address']['geo']['lng']}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text('Phone: ${data!['phone']}'),
                Text('Website: ${data!['website']}'),
                const Text('Company:'),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${data!['company']['name']}'),
                      Text('Catch Phrase: ${data!['company']['catchPhrase']}'),
                      Text('BS: ${data!['company']['bs']}'),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Text('No data available');
        }
      },
    );
  }
}
