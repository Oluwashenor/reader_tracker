import 'package:flutter/material.dart';
import 'package:reader_tracker/models/book.dart';
import 'package:reader_tracker/network/network.dart';

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
    _searchBooks("Android");
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
            Expanded(
                child: GridView.builder(
                    itemCount: _books.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.6),
                    itemBuilder: (context, index) {
                      final Book book = _books[index];
                      return Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Image.network(
                                  book.imageLinks['thumbnail'] ?? '',
                                  scale: 1.2),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                book.title,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                book.authors.join(', & '),
                                style: Theme.of(context).textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )
                          ],
                        ),
                      );
                    }))
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