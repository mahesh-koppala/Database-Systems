package library_management;

public class User {
	int cardNo;
	long ssn;
	String type;
	String name;
	String campus;
	String phone;
	String address;
	public int getCardNo() {
		return cardNo;
	}
	public void setCardNo(int cardNo) {
		this.cardNo = cardNo;
	}
	public long getSsn() {
		return ssn;
	}
	public void setSsn(int ssn) {
		this.ssn = ssn;
	}
	public String getType() {
		return type;
	}
	public User(int cardNo, int ssn, String type, String name, String campus, long l, String address) {
		super();
		this.cardNo = cardNo;
		this.ssn = ssn;
		this.type = type;
		this.name = name;
		this.campus = campus;
		this.phone = phone;
		this.address = address;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCampus() {
		return campus;
	}
	public void setCampus(String campus) {
		this.campus = campus;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
}
