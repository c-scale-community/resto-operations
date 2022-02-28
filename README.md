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

Create user:

    endpoint=http://147.251.124.35:5252
    cat <<EOF > user.json
    {
      "name": "LOGIN",
      "firstname": "First",
      "bio": "Bio",
      "lastname": "Last",
      "topics": "Topics",
      "country": "cz",
      "organization": "CESNET",
      "password": "PASSWORD",
      "email": "EMAIL@example.com"
    }
    EOF
    curl -i -X POST "$endpoint/users" -H 'Content-Type: application/json' -H 'Accept: application/json' -d @$(pwd)/user.json
