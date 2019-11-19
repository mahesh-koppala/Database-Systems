package library_management;

public class Book {
	long isbn;
	String title;
	String subject;
	String author;
	int quantity;
	String binding;
	String type;
	int rare_outofprint;
	public Book() {
		
	}
	public long getIsbn() {
		return isbn;
	}
	public void setIsbn(int isbn) {
		this.isbn = isbn;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Book(long isbn, String title, String subject, String author, int quantity,
			String binding, String type, int rare_outofprint) {
		super();
		this.isbn = isbn;
		this.title = title;
		this.subject = subject;
		this.author = author;
		this.quantity = quantity;
		this.binding = binding;
		this.type = type;
		this.rare_outofprint = rare_outofprint;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getBinding() {
		return binding;
	}
	public void setBinding(String binding) {
		this.binding = binding;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getRare_outofprint() {
		return rare_outofprint;
	}
	public void setRare_outofprint(int rare_outofprint) {
		this.rare_outofprint = rare_outofprint;
	}
}
