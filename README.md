Steps (remote machines):

    apt-get update
    apt-get install -y python

Steps (control machine):

    apt-get install -y python3-dnspython
    cp inventory.example inventory
    # modify
    #vim inventory
    ansible-playbook ./site.yaml

Create user:

    endpoint=http://127.0.0.1
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

    token="$(curl -i -X GET -u EMAIL@example.com:PASSWOD "$endpoint/auth" -H 'Accept: application/json' | jq -r .token)"

    curl -i -X PUT "$endpoint/auth/activate/$token" -H 'Accept: application/json'

Complete cleanup of all users:

    docker exec -it resto_restodb_1 psql -U resto resto -c "DELETE FROM \"user\" WHERE email!='admin'"
