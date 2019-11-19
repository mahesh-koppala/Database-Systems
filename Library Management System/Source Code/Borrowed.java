package library_management;

import java.util.Date;

public class Borrowed {

	long isbn;
	long ssn;
	Date check_out_date;
	Date due_date;
	
	public Borrowed(long isbn, long ssn, Date check_out_date, Date due_date) {
		super();
		this.isbn = isbn;
		this.ssn = ssn;
		this.check_out_date = check_out_date;
		this.due_date = due_date;
	}
	public long getIsbn() {
		return isbn;
	}
	public void setIsbn(long isbn) {
		this.isbn = isbn;
	}
	public long getSsn() {
		return ssn;
	}
	public void setSsn(int ssn) {
		this.ssn = ssn;
	}
	public Date getCheck_out_date() {
		return check_out_date;
	}
	public void setCheck_out_date(Date check_out_date) {
		this.check_out_date = check_out_date;
	}
	public Date getDue_date() {
		return due_date;
	}
	public void setDue_date(Date due_date) {
		this.due_date = due_date;
	}
	
}
