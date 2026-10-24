import '../models/book.dart';
import '../models/student.dart';

class LibraryManager {
  final List<Book> books = [];
  final List<Student> students = [];

  void addBook(Book book) {
    books.add(book);
  }

  void addStudent(Student student) {
    students.add(student);
  }

  void borrowBook(Student student, Book book) {
    student.borrowBook(book);
  }

  void returnBook(Student student, Book book) {
    student.returnBook(book);
  }
}