import 'package:flutter/material.dart';

import '../models/book.dart';
import '../models/student.dart';
import '../services/library_manager.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final LibraryManager manager = LibraryManager();

  late Student currentStudent;

  final TextEditingController nameController =
      TextEditingController(text: 'Nguyen Van A');

  @override
  void initState() {
    super.initState();

    currentStudent = Student(
      id: 1,
      name: 'Nguyen Van A',
    );

    manager.addStudent(currentStudent);

    manager.addBook(
      Book(
        id: 1,
        title: 'Sách 01',
      ),
    );

    manager.addBook(
      Book(
        id: 2,
        title: 'Sách 02',
      ),
    );
  }

  void changeStudentName() {
    setState(() {
      currentStudent.name = nameController.text;
    });
  }

  void toggleBook(Book book) {
    setState(() {
      if (currentStudent.borrowedBooks.contains(book)) {
        manager.returnBook(
          currentStudent,
          book,
        );
      } else {
        manager.borrowBook(
          currentStudent,
          book,
        );
      }
    });
  }

  void addBook() {
    setState(() {
      final int newId = manager.books.length + 1;

      manager.addBook(
        Book(
          id: newId,
          title: 'Sách ${newId.toString().padLeft(2, '0')}',
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Hệ thống\nQuản lý Thư viện',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sinh viên',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: changeStudentName,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF3564C9),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 17,
                    ),
                  ),
                  child: const Text('Thay đổi'),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'Danh sách sách',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: manager.books.map((book) {
                  final bool borrowed =
                      currentStudent.borrowedBooks.contains(book);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(8),
                    ),
                    child: CheckboxListTile(
                      value: borrowed,
                      activeColor: Colors.redAccent,
                      title: Text(book.title),
                      controlAffinity:
                          ListTileControlAffinity.leading,
                      onChanged: (_) {
                        toggleBook(book);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: addBook,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF3564C9),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Thêm'),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              currentStudent.getInfo(),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF3564C9),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Quản lý',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'DS Sách',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Sinh viên',
          ),
        ],
      ),
    );
  }
}