return {
	-- mysql配置
	mysql = {
		timeout = 5000,
		connect_config = {
			host = "",
	        port = 3306,
	        database = "otp",
	        user = "",
	        password = "",
	        max_packet_size = 1024 * 1024
		},
		pool_config = {
			max_idle_timeout = 20000, -- 20s
        	pool_size = 5 -- connection pool size
		}
	}

}
