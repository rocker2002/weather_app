import 'dart:async';

import 'package:flutter/material.dart';
import '../models/location.dart';


class LocationSearchDelegate extends SearchDelegate<Location?>{
  final Future<List<Location>> Function(String query) searchFunction;
  Timer? _debounceTimer;

  LocationSearchDelegate({required this.searchFunction});


  @override
  void dispose() {
    _debounceTimer?.cancel(); 
    super.dispose();
  }

  

  @override
  List<Widget> buildActions(BuildContext context){
    return [IconButton(
      onPressed: ()
      {query='';}, 
      icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context){
    return IconButton(
      onPressed: () => close(context, null), 
      icon: Icon(Icons.arrow_back)
      );
  }

  @override
  Widget buildResults(BuildContext context){
    return buildFutureResults();
  }

  @override
  Widget buildSuggestions(BuildContext context){
    return buildFutureSuggestions();
  }

  Widget buildFutureResults() {
    if (query.isEmpty) return Container();

    return FutureBuilder<List<Location>>(
      future: searchFunction(query), 
      builder: (context, snapshot){
         if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final results = snapshot.data ?? [];

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index){
            final location = results[index];
            return ListTile(
              title: Text(location.name),
              subtitle: Text(location.countryName),
              onTap: () => close(context, location),
            );
          });
      }
      );
  }

  Widget buildFutureSuggestions(){
    if (query.isEmpty) {
      return const Center(
        child: Text('Start typing to search Locations'),
      );
    }

    return FutureBuilder<List<Location>>(
      future: searchFunction(query), 
      builder: (context, snapshot){
         if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final suggestions = snapshot.data ?? [];
        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index){
            final location = suggestions[index];
            return ListTile(
              title: Text(location.name),
              subtitle: Text(location.countryName),
              onTap: () {
                close(context, location);
              }
            );
          });
      }
      );
      }
      
  void onQueryChanged(BuildContext context, String newQuery) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (newQuery.isNotEmpty) {
        showSuggestions(context);
      }
    });
  }  
  }