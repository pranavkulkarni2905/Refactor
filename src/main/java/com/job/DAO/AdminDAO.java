package com.job.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

public class AdminDAO {

	Connection con = null;
	PreparedStatement ps = null;
	
	public int addNonITJob(String title, String type, String location, String salary,
			String deadline, String desc, String vacancy, String skills) {
		int i = 0;
		Timestamp date = new Timestamp(new Date().getTime());
		con = DBConnection.getConnection();
		try {
			ps = con.prepareStatement("insert into non_it_job_post(job_title,jo_type,job_location,job_vaccancy,salary,deadline,job_desc,skill_qualification,posted_date) values(?,?,?,?,?,?,?,?,?)");
			ps.setString(1, title);
			ps.setString(2, type);
			ps.setString(3, location);
			ps.setString(4, vacancy);
			ps.setString(5, salary);
			ps.setString(6, deadline);
			ps.setString(7, desc);
			ps.setString(8, skills);
			ps.setTimestamp(9, date);
			
			i = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return i;
	}

	
}