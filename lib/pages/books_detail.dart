import 'package:flutter/material.dart';
import 'package:reader_tracker/utils/arguments/book_details_arguments.dart';

import '../models/book.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as BookDetailsArguments;
    final Book book = args.itemBook;
    final texttheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        // scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (book.imageLinks.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.network(book.imageLinks['thumbnail'] ?? '',
                    fit: BoxFit.cover),
              ),
            Column(
              children: [
                Text(
                  book.title,
                  style: texttheme.headlineSmall,
                ),
                Text(
                  book.authors.join(', '),
                  style: texttheme.labelLarge,
                ),
                Text(
                  'Published : ${book.publishedDate}',
                  style: texttheme.bodySmall,
                ),
                Text(
                  'Page Count : ${book.pageCount}',
                  style: texttheme.bodySmall,
                ),
                Text('Language : ${book.language}', style: texttheme.bodySmall),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () {}, child: const Text("Save")),
                    ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite),
                        label: const Text("Favorite"))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Descritpion"),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.secondary)),
                  child: Text(book.description),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
