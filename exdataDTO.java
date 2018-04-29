package exdata;

public class exdataDTO {

	
	String table_name;
	String environment;
	String channel;
	String ch_bw;
	
	
	public exdataDTO() {
		
	}
	
	
	public exdataDTO(String table_name, String environment, String channel, String ch_bw) {
		this.table_name = table_name;
		this.environment = environment;
		this.channel = channel;
		this.ch_bw = ch_bw;
	}
	
	public String getTable_name() {
		return table_name;
	}
	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}
	public String getEnvironment() {
		return environment;
	}
	public void setEnvironment(String environment) {
		this.environment = environment;
	}
	public String getChannel() {
		return channel;
	}
	public void setChannel(String channel) {
		this.channel = channel;
	}
	public String getCh_bw() {
		return ch_bw;
	}
	public void setCh_bw(String ch_bw) {
		this.ch_bw = ch_bw;
	}
	
	
	
}
