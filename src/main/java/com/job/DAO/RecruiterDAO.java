package com.job.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

import com.job.model.Recruiter;
import com.job.model.User;

public class RecruiterDAO {
	
	Connection con = null;
	PreparedStatement ps = null;

	public int registerRecruiter(String name, String email, String password,String phone,String cmpName) {
		int i = 0;
		//Timestamp date = new Timestamp(new Date().getTime());
		con = DBConnection.getConnection();
		try {
			ps = con.prepareStatement("insert into recrutier_profile(hr_name,hr_email,hr_phone,company_name,password,verified) values(?,?,?,?,?,?)");
			ps.setString(1, name);
			ps.setString(2, email);
			ps.setString(3, phone);
			ps.setString(4, cmpName);
			ps.setString(5, password);
			ps.setString(6, "No");
			
			i = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return i;
	}

	public Recruiter checkRecruiter(String email, String password) {
		// TODO Auto-generated method stub
		Recruiter r = null;
		con = DBConnection.getConnection();
		try {
			ps = con.prepareStatement("select * from recrutier_profile where hr_email=? and password=?");
			ps.setString(1, email);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				r = new Recruiter(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getString(8),rs.getString(9),rs.getString(10),rs.getString(11),rs.getString(12),rs.getString(13),rs.getString(14),rs.getString(15),rs.getString(16),rs.getString(17),rs.getString(18),rs.getString(19),rs.getString(20),rs.getString(21),rs.getString(22));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return r;
	
	}

	public int addJob(int recruiterId, String cmpName, String title, String type, String location, String salary,
			String deadline, String desc, String vacancy, String skills) {
		int i = 0;
		Timestamp date = new Timestamp(new Date().getTime());
		con = DBConnection.getConnection();
		try {
			ps = con.prepareStatement("insert into job_post(recruiter_id,company_name,job_title,jo_type,job_location,job_vaccancy,salary,deadline,job_desc,skill_qualification,posted_date) values(?,?,?,?,?,?,?,?,?,?,?)");
			ps.setInt(1, recruiterId);
			ps.setString(2, cmpName);
			ps.setString(3, title);
			ps.setString(4, type);
			ps.setString(5, location);
			ps.setString(6, vacancy);
			ps.setString(7, salary);
			ps.setString(8, deadline);
			ps.setString(9, desc);
			ps.setString(10, skills);
			ps.setTimestamp(11, date);
			
			i = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return i;
	}

	public Recruiter getRecruiterDataById(int id) {
		Recruiter f1 = null;
		ResultSet rs = null;
		con = DBConnection.getConnection();
		try {
			ps = con.prepareStatement("select * from recruiter_profile where recruiter_id=?");
			ps.setInt(1, id);
			rs = ps.executeQuery();
			if (rs.next()) {
				f1 = new Recruiter(rs.getInt(1),rs.getString(2),rs.getString(3),rs.getString(4),rs.getString(5),rs.getString(6),rs.getString(7),rs.getString(8),rs.getString(9),rs.getString(10),rs.getString(11),rs.getString(12),rs.getString(13),rs.getString(14),rs.getString(15),rs.getString(16),rs.getString(17),rs.getString(18),rs.getString(19),rs.getString(20),rs.getString(21),rs.getString(22));

			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return f1;
	}
	
	public ResultSet getAllRecruiters() {
		con = DBConnection.getConnection();
		ResultSet rs = null;
		try {
			ps = con.prepareStatement("select * from recrutier_profile");
			rs = ps.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
}
