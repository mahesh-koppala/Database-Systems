


import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Scanner;
import java.util.concurrent.TimeUnit;

import library_management.Book;
import library_management.Borrowed;
import library_management.User;

public class Library {

    private User user = null;

    public static void main(String[] args) throws SQLException {
        boolean flag = true;
        User user = null;
        Library library = new Library();
        boolean validUser = false;
        Scanner sc = new Scanner(System.in);
        sc.useDelimiter("\\n");
        String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
        String USER = "mah";
        String PASSWORD = "qwertyui";
        String query = null;
        Driver myDriver = new oracle.jdbc.driver.OracleDriver();
        DriverManager.registerDriver(myDriver);
        Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
        Statement statement = conn.createStatement();
        System.out.println("Welcome to the UTA Library!!!!!\nPlease enter your card no to proceed: ");
        int cardNo = Integer.parseInt(sc.next().trim());
        validUser = library.validateUser(sc, user, cardNo, statement);
        while (true) {
            System.out.println("what do you wanna do ?\n");
            System.out.println("0. Search for books\n");
            System.out.println("1. Borrow books.\n");
            System.out.println("2. Add a new Member.\n");
            System.out.println("3. Return books.\n");
            System.out.println("4. Add a new Book.\n");
            System.out.println("5. Generate a report. \n");
            System.out.println("6. Trigger a report. \n");
            System.out.println("7. Renew membership. \n");
            System.out.println("8. Exit\n");
            System.out.println("Make a choice:");
            int choice = Integer.parseInt(sc.next().trim());
            switch (choice) {
                case 0:
                    library.searchForBooks(sc, query, statement);
                    break;
                case 1:
                    library.searchAndBorrowBooks(sc, query, statement);
                    break;
                case 2:
                    library.getMembership(sc, query, statement);
                    break;
                case 3:
                    library.returnBooks(sc, query, statement);
                    break;
                case 4:
                    library.addBook(sc, query, statement);
                    break;
                case 5:
                    library.generateReport(sc, query, statement, conn);
                    break;
                case 6:
                    library.trigger(query, statement, conn);
                    break;
                case 7:
                    library.renewMembership(sc, query, statement);
                    break;
                case 8:
                    System.exit(1);
                    break;
                default:
                    System.out.println("Please select an option from the choices");
            }
            System.out.println("\n\nDo you want to transact ? Enter 1 for yes or 0 for no: ");
            int input = Integer.parseInt(sc.next().trim());
            if (input == 1) {
                flag = true;
            } else {
                System.out.println("Exitting from Library.");
                flag = false;
            }
        }
 //       sc.close();
    }

    private void renewMembership(Scanner sc, String query, Statement statement) throws SQLException {
        SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
        Calendar c = Calendar.getInstance();
        c.setTime(new Date());
        c.add(Calendar.DATE, 1460);
        String new_expiry = sdf.format(c.getTime());
        System.out.println("Enter the card no of the member you want to renew: ");
        int cardNo = Integer.parseInt(sc.next().trim());
        System.out.println(new_expiry);
        query = "UPDATE MEMBERS SET EXPIRY_DATE=TO_DATE('"+new_expiry+"', 'YYYY-MM-DD') WHERE card_no="+cardNo+"";
        System.out.println(query);
        int rows = statement.executeUpdate(query);
        if(rows>0) {
            System.out.println("membership renewed succesfully for 4 years.");
        }
    }

    private void trigger(String query, Statement statement, Connection conn) {

        try {
            String query1 = "";
            Date tdate = new Date();
            //            query = "CREATE OR REPLACE TRIGGER display_outstanding_overdue \n" +
            //                    "AFTER DELETE OR INSERT OR UPDATE ON borrows \n" +
            //                    "FOR EACH ROW \n" +
            //                    "WHEN (tdate > due_date) \n" +
            //                    "BEGIN \n" +
            //                    "INSERT INTO trig VALUES(" + isbn + "," + this.user.getSsn() + "," + fine + ", " + "to_date('" + df.format(date) + "', 'yyyy-MM-DD'))" +
            //                    "END; ";
            //            ResultSet result = statement.executeQuery(query);

            query = " select SSN,NAME,EXPIRY_DATE from members where EXPIRY_DATE <= trunc(sysdate)";
            ResultSet result = statement.executeQuery(query);
            while (result.next()) {

                long ssn = result.getLong("SSN");
                Date expiry_date = result.getDate("EXPIRY_DATE");
              //  String name = result.getString("NAME");
                String name = "km";
                System.out.println(ssn+ " : your memebership has been expired on "+ expiry_date);

                Statement statement1 = conn.createStatement();
                String query2 = "";
                query2 = " merge into trig a" +
                        " using" +
                        "      ( select "+ssn+" as ssn, '"+ name+"' as nm from dual) b" +
                        "    on (a.ssn = b.ssn)" +
                        "    when matched then" +
                        "      update set a.ISMEMBEREXPIRE = 'Y' " +
                        "    when not matched then" +
                        "     insert ( a.ssn, a.fname, a.ISMEMBEREXPIRE) " +
                        "     values ( b.ssn, b.nm, 'Y')";
                statement1.executeUpdate(query2);

                statement1.close();
            }


            Statement statement1 = conn.createStatement();
            query1 = " select ISBN, SSN,CHECK_OUT_DATE, DUE_DATE from BORROWS b1 where DUE_DATE <= trunc(sysdate) AND b1.SSN not in (SELECT r1.SSN FROM returns r1 where b1.SSN=r1.SSN  and b1.ISBN=r1.ISBN   )";
            ResultSet resultt = statement1.executeQuery(query1);
            while (resultt.next()) {
                long isbn = resultt.getLong("ISBN");
                long ssn = resultt.getLong("SSN");
               // String name = result.getString("name");
                String name1 = "autumn";
                Date check_out_date = resultt.getDate("CHECK_OUT_DATE");
                Date due_date = resultt.getDate("DUE_DATE");

                System.out.println(ssn+ " : your due date has already passed on "+ due_date);

                Statement statement3 = conn.createStatement();
                String query3 = "";
                query3 = " merge into trig a" +
                        " using" +
                        "      ( select "+isbn+" as isbn, "+ssn+" as ssn, '"+name1+"' as nm from dual) b" +
                        "    on (a.ssn = b.ssn and a.isbn = b.isbn)" +
                        "    when matched then" +
                        "      update set a.ISOVERDUE = 'Y' " +
                        "    when not matched then" +
                        "     insert ( a.ssn, a.isbn, a.fname, a.ISOVERDUE) " +
                        "     values ( b.ssn, b.isbn, b.nm, 'Y')";
                statement3.executeUpdate(query3); // select 'someid' id,  'testKey' key,  'someValue' value from   dual

            }
        } catch (Exception ee) {
            ee.printStackTrace();
            System.out.println("" + ee.getLocalizedMessage());
        }

    }

    private void generateReport(Scanner sc, String query, Statement statement, Connection conn) {
        File file = new File("E:/report.csv");
        FileWriter fileWriter;
        try {
            fileWriter = new FileWriter(file);
            String query1 = "";
            query = "select distinct book.ISBN as isbn, borrows.SSN as SSN, subject_area, author, quantity, borrows.check_out_date as cDate from book, borrows where book.ISBN = borrows.ISBN and  check_out_date >= TRUNC(SYSDATE) - 7";
            ResultSet result = statement.executeQuery(query);
            while (result.next()) {
                long isbn = result.getLong("isbn");
                long ssn = result.getLong("SSN");
                String area = result.getString("subject_area");
                String author = result.getString("author");
                String quantity = result.getString("quantity");
                Date check_out_date = result.getDate("cDate");
                long totalLoaned = 0;
                Statement statement1 = conn.createStatement();
                query1 = "select borrows.ISBN as isbn, borrows.SSN as SS,  borrows.check_out_date as check_Date, returns.return_date as return_Date from  borrows, returns where returns.ISBN = borrows.ISBN and  returns.SSN = borrows.SSN and returns.ISBN = " + isbn;
                ResultSet resultt = statement.executeQuery(query1);

                while (resultt.next()) {
                    Date checkOutDate = resultt.getDate("check_Date");
                    Date returnDate = resultt.getDate("return_Date");
                    long diffInMillies = Math.abs(returnDate.getTime() - checkOutDate.getTime());
                    long diff = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
                    totalLoaned += diff;
                }
                fileWriter.append("ISBN");
                fileWriter.append(',');
                fileWriter.append("Subject Area");
                fileWriter.append(',');
                fileWriter.append("Author");
                fileWriter.append(',');
                fileWriter.append("Quantity");
                fileWriter.append(',');
                fileWriter.append("Total Days Loaned");
                fileWriter.append('\n');

                fileWriter.append("" + isbn);
                fileWriter.append(',');
                fileWriter.append("" + area);
                fileWriter.append(',');
                fileWriter.append("" + author);
                fileWriter.append(',');
                fileWriter.append("" + quantity);
                fileWriter.append(',');
                fileWriter.append("" + totalLoaned);
                fileWriter.append('\n');
            }
            fileWriter.flush();
            fileWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("" + e.getLocalizedMessage());
        } catch (SQLException ee) {
            ee.printStackTrace();
            System.out.println("" + ee.getLocalizedMessage());
        }
    }

    private void addBook(Scanner sc, String query, Statement statement) throws SQLException {
        sc.useDelimiter("\\n");
        System.out.println("Enter book ISBN(Should be 13 digits): ");
        long isbn = Long.parseLong(sc.next().trim());
        System.out.println("Enter title of the book: ");
        String title = sc.next();
        System.out.println("Enter Subject: ");
        String subject = sc.next();
        System.out.println("Enter Author name: ");
        String author = sc.next();
        System.out.println("Enter the no of books available: ");
        int quantity = Integer.parseInt(sc.next().trim());
        System.out.println("Enter binding type: ");
        String binding = sc.next();
        System.out.println("Enter book type: ");
        String type = sc.next();
        System.out.println("Is the book rare ? Enter 1 for yes or 0 for No: ");
        int rare = Integer.parseInt(sc.next().trim());
        
        query = "Insert into Book values(";
        int rows = statement.executeUpdate(query + isbn + ",'" + title + "','" + subject + "','" + author + "'," + quantity + ",'" + binding + "','" + type + "'," + rare + ")");
        if (rows > 0) {
            System.out.println("New Book added Succesfully.");
            System.out.println("\nISBN\t\tTITLE\t\t\tSUBJECT\tAUTHOR\tNo Of Books Available Binding\tTYPE\tRARE_OUTOFPRINT BOOK DESCRIPTION");
            System.out.println("\n"+isbn+"\t"+title+"\t"+subject+"\t"+author+"\t"+quantity+"\t"+binding+"\t"+type+"\t"+rare+" ");
        }
    }

    private void returnBooks(Scanner s, String query, Statement statement) throws SQLException {
        long fine = 0;
        List<Borrowed> borrowed = new ArrayList<Borrowed>();
        Date check_out = null;
        Calendar calendar = new GregorianCalendar();
        calendar.add(Calendar.DATE, 30);
        DateFormat df = new SimpleDateFormat("YYYY-MM-dd");
        Date date = new Date();
        query = "SELECT ISBN, check_out_date as Date_Borrowed, due_date from Borrows where ssn=" + this.user.getSsn();
        ResultSet result = statement.executeQuery(query);
        while (result.next()) {
            System.out.println("Books you borrowed are: ");
            Date due = result.getDate("due_date");
            long isbn = result.getLong("isbn");
            Date borrowedDate = result.getDate("Date_Borrowed");
            Borrowed borrow = new Borrowed(isbn, this.user.getSsn(), borrowedDate, due);
            borrowed.add(borrow);
            System.out.println("ISBN\t\tSSN\t\tBorrowed On\t\tDue by\t\t");
            System.out.printf("%d\t%d\t%s\t%s\t\n", isbn, this.user.getSsn(), borrowedDate, due);
        }
        System.out.print("Enter the ISBN of the book you want to return: ");
        long isbn = Long.parseLong(s.next().trim());
        for (Borrowed b : borrowed) {
            if (b.getIsbn() == isbn) {
                check_out = b.getCheck_out_date();
            }
        }
        long diffInMillies = Math.abs(date.getTime() - check_out.getTime());
        long diff = TimeUnit.DAYS.convert(diffInMillies, TimeUnit.MILLISECONDS);
        System.out.println(diff);
        if (diff > 30) {
            fine = (diff - 30) * 1;
        }
        //		System.out.println("INSERT INTO RETURNS VALUES(" + isbn + "," + this.user.getSsn() + "," + fine + ", " + "to_date('" + df.format(date) + "', 'YYYY-MM-DD'))");
        int rows = statement.executeUpdate("INSERT INTO RETURNS VALUES(" + isbn + "," + this.user.getSsn() + "," + fine + ", " + "to_date('" + df.format(date) + "', 'YYYY-MM-DD'))");
        if (rows == 1) {
            System.out.println("ISBN\t\tSSN\t\tFine for Late Returns\tReturned On");
            System.out.println("" + isbn + "\t" + this.user.getSsn() + "\t" + fine + "\t" + date);
            System.out.println("Book returned successfully.");
        }
    }

    private void getMembership(Scanner sc, String query, Statement statement) throws SQLException {
        SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
        Date date = new Date();
        Calendar c = Calendar.getInstance();
        c.setTime(new Date());
        c.add(Calendar.DATE, 1460);
        String expiry_date = sdf.format(c.getTime());
        System.out.print("Please enter your SSN: ");
        long ssn = Long.parseLong(sc.next().trim());
        int cardno = 0;
        String check = String.valueOf(ssn);
        System.out.print("Enter the user type: (Student/Professor) ?");
        String member = sc.next().trim();
        if (!member.equalsIgnoreCase("student") || member.equalsIgnoreCase("professor")) {
            System.out.println("Please enter valid memeber type");
        }
        System.out.print("Enter your name: ");
        String name = sc.next().trim();
        System.out.print("Enter your phone no: ");
        String phone = sc.next().trim();
        System.out.print("Enter the campus: ");
        String campus = sc.next().trim();
        System.out.print("Enter your address: ");
        String address = sc.next().trim();
        if (check.matches("[0-9]{9}") && phone.matches("[0-9]{10}")) {
            query = "INSERT INTO MEMBERS(CARD_NO,SSN,TYPE,NAME,CAMPUS,PHONE,ADDRESS,JOINED_DATE,EXPIRY_DATE) VALUES("+(cardno+1)+","+ssn+",'"+member+"','"+name+"','"+campus+"',"+phone+",'"+address+"',to_date('"+sdf.format(date)+"','YYYY-MM-DD'), to_date('"+expiry_date+"','YYYY-MM-DD'))";
//			System.out.println(query);
            int rowsAfftected = statement.executeUpdate(query);
            if (rowsAfftected == 1) {
                System.out.println(name + ", Welcome to the Library family");
                ResultSet result = statement.executeQuery("SELECT *from Members where ssn=" + ssn);
                if (result.next()) {
                    int cardNo = result.getInt("card_no");
                    String type = result.getString("type");
                    String uname = result.getString("name");
                    String ccampus = result.getString("campus");
                    long uphone = result.getLong("phone");
                    String uaddress = result.getString("address");
                    Date joined = result.getDate("joined_date");
                    Date expired = result.getDate("expiry_date");
                    System.out.println("\nCARDNO\tNAME\tTYPE\tCAMPUS\tPHONE\t\tADDRESS\t\tJOINED ON\tEXPIRY DATE");
                    System.out.print("\n"+cardNo+"\t"+uname+"\t"+type+"\t"+ccampus+"\t"+uphone+"\t"+uaddress+" "+joined+"\t"+expired);
                }
            }

        } else {
            System.out.println("Please enter valid values");
        }
    }

    private void searchAndBorrowBooks(Scanner sc, String query, Statement statement) throws SQLException {
        boolean canBorrow = false;
        System.out.println(this.user);
        List<Book> listOfBooks = searchForBooks(sc, query, statement);
        String que = "SELECT COUNT(ISBN) as count FROM BORROWS WHERE SSN="+this.user.getSsn();
        ResultSet res = statement.executeQuery(que);
        if(res.next()) {
            int booksCount = res.getInt("count");
            if(booksCount<5)
                canBorrow = true;
        }
        if (listOfBooks.size() > 1) {
            System.out.print("Enter the ISBN of the book you want to borrow: ");
            int isbn = sc.nextInt();
            for (Book book : listOfBooks) {
                if (book.getIsbn() == isbn) {
                    if ((book.getRare_outofprint() == 1) && (book.getType() == "maps" || book.getType() == "reference")) {
                        System.out.println("This book can't be lent as it's either a reference book or rare book");
                    } else if(canBorrow){
                        borrowBook(book, statement);
                    }else {
                        System.out.println("Looks like you have borrowed 5 books already! Please return some to borrow book again!");
                    }
                }
            }
        } else if(canBorrow){
            borrowBook(listOfBooks.get(0), statement);
        }else {
            System.out.println("Looks like you have borrowed 5 books already! Please return some to borrow book again!");
        }
    }

    private boolean validateUser(Scanner sc, User user, int cardNo, Statement statement) throws SQLException {
        String query = "Select *from Members where card_no = " + cardNo;
        ResultSet result = statement.executeQuery(query);
        if (result.next()) {
            this.user = new User(cardNo, result.getInt("ssn"), result.getString("type"), result.getString("name"), result.getString("campus"), result.getLong("phone"), result.getString("address"));
            return true;
        } else {
            System.out.print("Please get your membership to access the library resources!!!");
            System.out.print("Do you want to get Library membership ?");
            System.out.println("Enter 1 to get membership 0 to not");
            int c = Integer.parseInt(sc.next().trim());
            if (c == 1) {
                getMembership(sc, null, statement);
            } else {
                return false;
            }
        }
        return false;
    }

    public List<Book> searchForBooks(Scanner sc, String query, Statement statement) throws SQLException {
        System.out.println("Enter the Title/ISBN of the book: ");
        String keyword = sc.next().trim();
        List<Book> listOfBooks = new ArrayList<Book>();
        if (keyword.matches("[0-9]{13}")) {
            query = "SELECT * from Book where isbn=" +keyword;
            ResultSet result = statement.executeQuery(query);
//            result.last();
//            System.out.println(result.getRow());
            if (result.next()) {
                System.out.println("Book is available!!!");
                Book book = new Book(result.getLong("isbn"), result.getString("title"), result.getString("subject_area"), result.getString("author"), result.getInt("quantity"), result.getString("binding"), result.getString("type"), result.getInt("rare_outofprint"));
                listOfBooks.add(book);
                System.out.println("\tISBN\t\tTitle\t\tSUBJECT_AREA\tAUTHOR\t\t\tQUANTITY\tBINDING\t\tTYPE\t\tRare_OUTOFPRINT\t\tBook_Description");
                System.out.println("\t" + book.getIsbn() + "\t" + book.getTitle() + "\t" + book.getSubject() + "\t" + book.getAuthor() + "\t" + book.getQuantity() + "\t\t" + book.getBinding() + "\t" + book.getType() + "\t" + book.getRare_outofprint() + "\t" );
            } else {
                System.out.println("Book is neither available nor your search didn't result any books.");
            }
        } else {
            query = "SELECT *from Book where title like '%" + keyword + "%'";
            ResultSet result = statement.executeQuery(query);
            boolean bookIsAvailable = false;
            while (result.next()) {
                long isbn = result.getLong("isbn");
                String title = result.getString("title");
                String subject = result.getString("subject_area");
                String book_description = result.getString("book_description");
                String author = result.getString("author");
                int quantity = result.getInt("quantity");
                String binding = result.getString("binding");
                String type = result.getString("type");
                int rare = result.getInt("rare_outofprint");
                Book book = new Book(isbn, title, subject, author, quantity, binding, type, rare);
                listOfBooks.add(book);
                System.out.println("\tISBN\t\tTitle\t\tSUBJECT_AREA\t\tAUTHOR\t\tQUANTITY\t\tBINDING\t\tTYPE\t\tRare_OUTOFPRINT\t\tBook_Description");
                System.out.println("\t" + book.getIsbn() + "\t" + book.getTitle() + "\t" + book.getSubject() + "\t" + book.getAuthor() + "\t" + book.getQuantity() + "\t\t" + book.getBinding() + "\t" + book.getType() + "\t" + book.getRare_outofprint() + "\t");
                bookIsAvailable = true;
            }
            if(!bookIsAvailable) {
                System.out.printf("Book %s is not available, Please check and try again later",keyword);
            }
        }
        return listOfBooks;
    }

    public void borrowBook(Book book, Statement statement) throws SQLException {
        DateFormat dateFormat = new SimpleDateFormat("YYYY-MM-dd");
        Calendar calendar = new GregorianCalendar();
        calendar.add(Calendar.DATE, 30);
        String d = dateFormat.format(calendar.getTime());
        Date date = new Date();
        System.out.println("" + this.user.getSsn());
        System.out.printf("You are borrowing the book: %s", book.getTitle());
        //		System.out.println("INSERT INTO BORROWS VALUES(" + book.getIsbn() + "," + this.user.getSsn() + ", to_date('" + dateFormat.format(date) + "','YYYY-MM-DD'), to_date('" + d + "','YYYY-MM-DD'))");
        statement.executeUpdate("INSERT INTO BORROWS VALUES(" + book.getIsbn() + "," + this.user.getSsn() + ", to_date('" + dateFormat.format(date) + "','YYYY-MM-DD'), to_date('" + d + "','YYYY-MM-DD'))");
    }
}
