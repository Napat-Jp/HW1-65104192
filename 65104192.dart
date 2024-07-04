import 'dart:io';

class Book {
  String title;
  String author;
  String isbn;
  int copies;

  Book(this.title, this.author, this.isbn, this.copies);

  void borrowBook() {
    if (copies > 0) {
      copies--;
      print('$title ถูกยืมไปแล้ว');
    } else {
      print('$title ไม่มีให้ยืม');
    }
  }

  void returnBook() {
    copies++;
    print('$title ถูกคืนแล้ว');
  }
}

class Member {
  String name;
  String memberId;
  List<Book> borrowedBooks = [];

  Member(this.name, this.memberId);

  void borrowBook(Book book) {
    if (book.copies > 0) {
      book.borrowBook();
      borrowedBooks.add(book);
      print('${name} ยืม ${book.title}');
    } else {
      print('${book.title} ไม่มีให้ยืม');
    }
  }

  void returnBook(Book book) {
    if (borrowedBooks.contains(book)) {
      book.returnBook();
      borrowedBooks.remove(book);
      print('${name} คืน ${book.title}');
    } else {
      print('${name} ไม่ได้ยืม ${book.title}');
    }
  }
}

class Library {
  List<Book> books = [];
  List<Member> members = [];

  void addBook(Book book) {
    books.add(book);
    print('${book.title} ถูกเพิ่มในห้องสมุด');
  }

  void removeBook(Book book) {
    books.remove(book);
    print('${book.title} ถูกลบออกจากห้องสมุด');
  }

  void registerMember(Member member) {
    members.add(member);
    print('${member.name} ถูกลงทะเบียนเป็นสมาชิก');
  }

  Book? findBookByIsbn(String isbn) {
    for (Book book in books) {
      if (book.isbn == isbn) {
        return book;
      }
    }
    return null;
  }

  Member? findMemberById(String memberId) {
    for (Member member in members) {
      if (member.memberId == memberId) {
        return member;
      }
    }
    return null;
  }

  void borrowBook(String memberId, String isbn) {
    Member? member = findMemberById(memberId);
    Book? book = findBookByIsbn(isbn);
    if (member != null && book != null) {
      member.borrowBook(book);
    } else {
      print('ไม่พบสมาชิกหรือหนังสือ');
    }
  }

  void returnBook(String memberId, String isbn) {
    Member? member = findMemberById(memberId);
    Book? book = findBookByIsbn(isbn);
    if (member != null && book != null) {
      member.returnBook(book);
    } else {
      print('ไม่พบสมาชิกหรือหนังสือ');
    }
  }
}

void main() {
  Library library = Library();

  // สร้างออบเจ็กต์ Book หลาย ๆ เล่ม
  Book book1 = Book('โศกนาฏกรรมแห่งเกรทแกรตส์บี', 'เอฟ. สก็อตต์ ฟิตซ์เจอรัลด์',
      '123456789', 3);
  Book book2 = Book('1984', 'จอร์จ ออร์เวลล์', '987654321', 2);

  // เพิ่มหนังสือในห้องสมุด
  library.addBook(book1);
  library.addBook(book2);

  // สร้างออบเจ็กต์ Member
  Member member1 = Member('สมชาย ใจดี', '001');
  Member member2 = Member('สมหญิง ศรีสุข', '002');

  // ลงทะเบียนสมาชิก
  library.registerMember(member1);
  library.registerMember(member2);

  while (true) {
    print('\nเมนูห้องสมุด:');
    print('1. ยืมหนังสือ');
    print('2. คืนหนังสือ');
    print('3. ลงทะเบียนสมาชิก');
    print('4. เพิ่มหนังสือ');
    print('5. ลบหนังสือ');
    print('6. ออกจากโปรแกรม');
    stdout.write('เลือกตัวเลือก: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('กรอกหมายเลขสมาชิก: ');
        String? memberId = stdin.readLineSync();
        stdout.write('กรอก ISBN ของหนังสือ: ');
        String? isbn = stdin.readLineSync();
        library.borrowBook(memberId!, isbn!);
        break;
      case '2':
        stdout.write('กรอกหมายเลขสมาชิก: ');
        String? memberId = stdin.readLineSync();
        stdout.write('กรอก ISBN ของหนังสือ: ');
        String? isbn = stdin.readLineSync();
        library.returnBook(memberId!, isbn!);
        break;
      case '3':
        stdout.write('กรอกชื่อสมาชิก: ');
        String? name = stdin.readLineSync();
        stdout.write('กรอกหมายเลขสมาชิก: ');
        String? memberId = stdin.readLineSync();
        Member newMember = Member(name!, memberId!);
        library.registerMember(newMember);
        break;
      case '4':
        stdout.write('กรอกชื่อหนังสือ: ');
        String? title = stdin.readLineSync();
        stdout.write('กรอกชื่อผู้แต่ง: ');
        String? author = stdin.readLineSync();
        stdout.write('กรอก ISBN ของหนังสือ: ');
        String? isbn = stdin.readLineSync();
        stdout.write('กรอกจำนวนสำเนาหนังสือ: ');
        int? copies = int.parse(stdin.readLineSync()!);
        Book newBook = Book(title!, author!, isbn!, copies);
        library.addBook(newBook);
        break;
      case '5':
        stdout.write('กรอก ISBN ของหนังสือที่ต้องการลบ: ');
        String? isbn = stdin.readLineSync();
        Book? bookToDelete = library.findBookByIsbn(isbn!);
        if (bookToDelete != null) {
          library.removeBook(bookToDelete);
        } else {
          print('ไม่พบหนังสือที่ต้องการลบ');
        }
        break;
      case '6':
        print('ออกจากโปรแกรม...');
        return;
      default:
        print('ตัวเลือกไม่ถูกต้อง กรุณาลองใหม่');
    }
  }
}
