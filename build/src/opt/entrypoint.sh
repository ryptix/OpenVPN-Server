#!/bin/sh

mkdir /etc/openvpn/log

if [ ! -f "/etc/openvpn/server.conf" ];then
	echo "Creating server.conf"

	if [ -n "${PORT}" ];then
		echo "Using port in ENV : ${PORT}" 
		echo "port ${PORT}" >> /etc/openvpn/server.conf
	else
		echo "Using default port : 1194"
		echo "port 1194" >> /etc/openvpn/server.conf
	fi

	if [ -n "${PROTO}" ];then
		echo "Using proto in ENV : ${PROTO}" 
		echo "proto ${PROTO}" >> /etc/openvpn/server.conf
	else
		echo "Using default proto : udp"
		echo "proto udp" >> /etc/openvpn/server.conf
	fi

	if [ -n "${DEV}" ];then
		echo "Using dev in ENV : ${DEV}" 
		echo "dev ${DEV}" >> /etc/openvpn/server.conf
	else
		echo "Using default dev : tun"
		echo "dev tun" >> /etc/openvpn/server.conf
	fi

	if [ -n "${OPENVPN_CA}" ];then
		if [ ! -f /etc/openvpn/${OPENVPN_CA} ];then
			echo "You're missing ${OPENVPN_CA}"
			exit 2
		else
			echo "Using ca in ENV : ${OPENVPN_CA}" 
			echo "ca ${OPENVPN_CA}" >> /etc/openvpn/server.conf
		fi	
	else
		echo "Using default ca.crt" 
		if [ ! -f /etc/openvpn/ca.crt ];then
			echo "You're missing ca.crt"
			exit 2
		else
			echo "ca ca.crt" >> /etc/openvpn/server.conf
		fi
	fi
		
	if [ -n "${OPENVPN_CERT}" ];then
		if [ ! -f /etc/openvpn/${OPENVPN_CERT} ];then
			echo "You're missing ${OPENVPN_CERT}"
			exit 2
		else
			echo "Using cert in ENV : ${OPENVPN_CERT}" 
			echo "cert ${OPENVPN_CERT}" >> /etc/openvpn/server.conf
		fi	
	else
		echo "Using default server.crt" 
		if [ ! -f /etc/openvpn/ca.crt ];then
			echo "You're missing server.crt"
			exit 2
		else
			echo "cert server.crt" >> /etc/openvpn/server.conf
		fi
	fi

	if [ -n "${OPENVPN_KEY}" ];then
		if [ ! -f /etc/openvpn/${OPENVPN_KEY} ];then
			echo "You're missing ${OPENVPN_KEY}"
			exit 2
		else
			echo "Using key in ENV : ${OPENVPN_KEY}" 
			echo "key ${OPENVPN_KEY}" >> /etc/openvpn/server.conf
		fi	
	else
		echo "Using default server.key" 
		if [ ! -f /etc/openvpn/server.key ];then
			echo "You're missing server.key"
			exit 2
		else
			echo "key server.key" >> /etc/openvpn/server.conf
		fi
	fi


	if [ -n "${OPENVPN_DH}" ];then
		if [ ! -f /etc/openvpn/${OPENVPN_DH} ];then
			echo "You're missing ${OPENVPN_DH}"
			exit 2
		else
			if [ -n "${OPENVPN_AUTH}" ];then

				echo "Using dh in ENV : ${OPENVPN_DH}"
				echo "dh ${OPENVPN_DH}" >> /etc/openvpn/server.conf
				echo "Using auth in ENV : ${OPENVPN_AUTH}"
				echo "auth ${OPENVPN_AUTH}" >> /etc/openvpn/server.conf
			else
				echo "Using dh in ENV : ${OPENVPN_DH}"
				echo "dh ${OPENVPN_DH}" >> /etc/openvpn/server.conf
				echo "Using default auth : SHA256"
				echo "auth SHA256" >> /etc/openvpn/server.conf
			fi
		fi	
	else
		echo "Using default dh.pem" 
		if [ ! -f /etc/openvpn/dh.pem ];then
			echo "You're missing dh.pem"
			exit 2
		else
			if [ -n "${OPENVPN_AUTH}" ];then

				echo "Using default dh : dh.pem"
				echo "dh dh.pem" >> /etc/openvpn/server.conf
				echo "Using auth in ENV : ${OPENVPN_AUTH}"
				echo "auth ${OPENVPN_AUTH}" >> /etc/openvpn/server.conf
			else
				echo "Using default dh : dh.pem"
				echo "dh dh.pem" >> /etc/openvpn/server.conf
				echo "Using default auth : SHA256"
				echo "auth SHA256" >> /etc/openvpn/server.conf
			fi
		fi
	fi
	
	if [ -n "${OPENVPN_TA}" ];then

		if [ ! -f /etc/openvpn/${OPENVPN_TA} ];then
			echo "You're missing ${OPENVPN_TA}"
			exit 2
		else
			echo "Using ta in ENV : ${OPENVPN_TA}" 
			echo "tls-auth ${OPENVPN_TA} 0" >> /etc/openvpn/server.conf
		fi	
	else
		echo "Using default ta.key" 
		if [ ! -f /etc/openvpn/ca.crt ];then
			echo "You're missing ta.key"
			exit 2
		else
			echo "tls-auth ta.key 0" >> /etc/openvpn/server.conf
		fi
	fi

	if [ -n "${SERVER_IP}" ];then
		if [ -n "${SERVER_MASK}" ];then
			echo "Using IP in ENV : ${SERVER_IP}"
		       	echo "Using MASK in ENV : ${SERVER_MASK}"	
			echo "server ${SERVER_IP} ${SERVER_MASK}" >> /etc/openvpn/server.conf
		else
			echo "Using IP in ENV : ${SERVER_IP}"
			echo "Using default MASK : 255.255.255.0"
			echo "server ${SERVER_IP} 255.255.255.0" >> /etc/openvpn/server.conf
		fi
	else
		if [ -n "${SERVER_MASK}" ];then
			echo "Using default IP : 10.8.0.0"
		       	echo "Using MASK in ENV : ${SERVER_MASK}"	
			echo "server 10.8.0.0 ${SERVER_MASK}" >> /etc/openvpn/server.conf
		else
			echo "Using default IP : 10.8.0.0"
			echo "Using default MASK : 255.255.255.0"
			echo "server 10.8.0.0 255.255.255.0" >> /etc/openvpn/server.conf	
		fi
	fi

	if [ -n "${PERSIST}" ];then
		echo "Using PERSIST in ENV : ${PERSIST}" 
		if [ ${PERSIST} ];then
			echo "(/etc/openvpn/log/ipp.txt)"
			echo "ifconfig-pool-persist /etc/openvpn/log/ipp.txt" >> /etc/openvpn/server.conf
		fi
	else
		echo "Using default PERSIST : true (/etc/openvpn/log/ipp.txt)"
		echo "ifconfig-pool-persist /etc/openvpn/log/ipp.txt" >> /etc/openvpn/server.conf
	fi	
	
	if [ -n "${LOG}" ];then
		echo "Using LOG in ENV : ${LOG}" 
		if [ ${LOG} ];then
			echo "(/etc/openvpn/log/*)"
			echo "status /etc/openvpn/log/openvpn-status.log" >> /etc/openvpn/server.conf
			echo "log /etc/openvpn/log/openvpn.log" >> /etc/openvpn/server.conf
		fi
	else
		echo "Using default LOG : true (/etc/openvpn/log/*)"
		echo "status /etc/openvpn/log/openvpn-status.log" >> /etc/openvpn/server.conf
		echo "log /etc/openvpn/log/openvpn.log" >> /etc/openvpn/server.conf
	fi	

	if [ -n "${VERB}" ];then
		echo "Using VERB in ENV : ${VERB}" 
		echo "verb ${VERB}" >> /etc/openvpn/server.conf
	else
		echo "Using default verb : 3"
		echo "verb 3" >> /etc/openvpn/server.conf
	fi
		
	if [ -n "${EXPLICIT_EXIT}" ];then
		echo "Using EXIT in ENV : ${EXPLICIT_EXIT}"
		if [ ${EXPLICIT_EXIT} ];then
			if [ "$PROTO" = "udp" ];then
				echo "explicit-exit-notify 1" >> /etc/openvpn/server.conf
			else
				echo "Don't use explicit-exit-notify with TCP"	
			fi
		fi
	else
		if [ "$PROTO" = "udp" ];then
			echo "Using default explicit-exit-notify 1"
			echo "explicit-exit-notify 1" >> /etc/openvpn/server.conf
		else
			echo "Not using explicit-exit-notify 1 cause TCP"	
		fi
	fi

	if [ -n "${CCD}" ];then
		echo "Using CCD in ENV : ${CCD}" 
		if [ ${CCD} ];then
			echo "(/etc/openvpn/ccd)"
			mkdir -p /etc/openvpn/ccd
		fi
	else
		echo "Using default CCD : false"
	fi	

	if [ -n "${REDIRECT_ALL}" ];then
		echo "Using REDIRECT_ALL in ENV : ${REDIRECT_ALL}" 
		if [ ${REDIRECT_ALL} ];then
			echo "push \"redirect-gateway def1 bypass-dhcp\"" >> /etc/openvpn/server.conf
		fi
	else
		echo "Using default REDIRECT_ALL : false"
	fi	
	
	if [ -n "${CLIENT_TO_CLIENT}" ];then
		echo "Using client-to-client in ENV : ${CLIENT_TO_CLIENT}" 
		if [ ${CLIENT_TO_CLIENT} ];then
			echo "client-to-client" >> /etc/openvpn/server.conf
		fi
	else
		echo "Using default client-to-client : true"
		echo "client-to-client" >> /etc/openvpn/server.conf
	fi

	if [ -n "${CIPHER}" ];then
		echo "Using CIPHER in ENV : ${CIPHER}"
		echo "cipher ${CIPHER}" >> /etc/openvpn/server.conf
	else
		echo "Using default CIPHER : AES-256-CBC"
		echo "cipher AES-256-CBC" >> /etc/openvpn/server.conf
	fi	
fi

echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

ip a


mkdir -p /dev/net/
if [ ! -c "/dev/net/tun" ];then
	mknod /dev/net/tun c 10 200
fi

cd /etc/openvpn && openvpn /etc/openvpn/server.conf
