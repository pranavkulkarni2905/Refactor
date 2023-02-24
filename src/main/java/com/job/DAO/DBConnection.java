package com.job.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	public static Connection getConnection() {
		Connection con = null;
		try {
			// load drivers
			Class.forName("oracle.jdbc.OracleDriver");
			// connection to data Base

<<<<<<< HEAD
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "12345");
=======
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "system");
>>>>>>> fdadad1bffbef4f27c87279ef08e5d58553a944c

		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con;
	}
}
