#!/bin/bash

UNENC_PW=$1
cat <<EOF | java -jar /opt/jenkins-cli.jar -s http://localhost:8080 -i /var/lib/jenkins/admin_id_rsa groovy =
import com.trilead.ssh2.crypto.Base64;
import javax.crypto.Cipher;
import jenkins.security.CryptoConfidentialKey;
import hudson.util.Secret;

CryptoConfidentialKey KEY = new CryptoConfidentialKey(Secret.class.getName());
Cipher cipher = KEY.encrypt();
String MAGIC = "::::MAGIC::::";


String VALUE_TO_ENCRYPT = "$UNENC_PW";
println(new String(Base64.encode(cipher.doFinal((VALUE_TO_ENCRYPT + MAGIC).getBytes("UTF-8")))));
EOF
