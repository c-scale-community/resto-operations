# Info

Playbooks and operations for [Resto](https://github.com/jjrom/resto/).

# Operations

Steps (remote machines):

    apt-get update
    apt-get install -y python

Steps (control machine):

    # when using credentials from vault
    . ./vault-login-egi.sh

    apt-get install -y python3-dnspython
    cp inventory.example inventory
    # modify
    #vim inventory
    ansible-playbook ./site.yaml

    # setup SSL
    #sh -xe ./HOWTO-certbot.sh

Create user:

    endpoint=http://127.0.0.1
    cat <<EOF > user.json
    {
      "name": "login",
      "firstname": "First",
      "bio": "Bio",
      "lastname": "Last",
      "topics": "Topics",
      "country": "au",
      "organization": "Org",
      "password": "password",
      "email": "email@example.com"
    }
    EOF
    curl -i -X POST "$endpoint/users" -H 'Content-Type: application/json' -H 'Accept: application/json' -d @$(pwd)/user.json

    token="$(curl -i -X GET -u EMAIL@example.com:PASSWOD "$endpoint/auth" -H 'Accept: application/json' | jq -r .token)"

    curl -i -X PUT "$endpoint/auth/activate/$token" -H 'Accept: application/json'

Complete cleanup of all users:

    docker exec -it resto_restodb_1 psql -U resto resto -c "DELETE FROM \"user\" WHERE email!='admin'"
