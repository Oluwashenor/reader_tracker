import 'package:flutter/material.dart';
import 'package:reader_tracker/models/book.dart';
import 'package:reader_tracker/network/network.dart';
import 'package:reader_tracker/pages/books_detail.dart';

import '../components/grid_view_widget.dart';
import '../utils/arguments/book_details_arguments.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Network network = Network();
  List<Book> _books = [];
  Future<void> _searchBooks(String query) async {
    try {
      List<Book> books = await network.searchBooks(query);
      setState(() {
        _books = books;
      });
      print("Books: ${books.toString()}");
    } catch (e) {
      print("Didnt get anything....");
    }
    setState(() {});
  }

  @override
  void initState() {
    _searchBooks("flutter");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                    hintText: 'Search for a book',
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                onSubmitted: (query) => _searchBooks(query),
              ),
            ),
            GridViewWidget(books: _books)
            // Expanded(
            //   child: SizedBox(
            //     width: double.infinity,
            //     child: ListView.builder(
            //         itemCount: _books.length,
            //         itemBuilder: (context, index) {
            //           Book book = _books[index];
            //           return ListTile(
            //             title: Text(book.title),
            //             subtitle: Text(book.authors.join(', & ') ?? ''),
            //           );
            //         }),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
