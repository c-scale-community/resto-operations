Steps (remote machines):

    apt-get update
    apt-get install -y python

Steps (control machine):

    apt-get install -y python3-dnspython
    cp inventory.example inventory
    echo "good-password" > secret-admin-password.txt
    echo "good-passprase" > secret-jwt-passphrase.txt
    chmod 0600 secret-*.txt
    ansible-playbook ./site.yaml
