# Info

Playbooks and operations for [Resto](https://github.com/jjrom/resto/).

## Operations

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

Create user:

    endpoint=https://127.0.0.1
    cat <<EOF >user.json
    {
      "username": "login",
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
    curl -k -i -X POST "$endpoint/users" -H 'Content-Type: application/json' -H 'Accept: application/json' -d @$(pwd)/user.json

    # local activation (by admin)
    read token
    curl -k -i -X PUT "$endpoint/auth/activate/$token" -H 'Accept: application/json'

Modify user:

	cat <<EOF >mod.json
	{
	  "password": "better-password"
	}
	EOF
	user=exampleuser
    read authadmin
    curl -k -i -u "$authadmin" -X POST "$endpoint/users/$user" -H 'Content-Type: application/json' -H 'Accept: application/json' -d @$(pwd)/user.json

Adding users to the groups:

    endpoint=https://example.com
    user=exampleuser
    group=xxx
    read authadmin
    curl -i -u "$authadmin" -X POST "$endpoint/groups/$group/users" -H 'Content-Type: application/json' -d"{\"username\":\"$user\"}"

## Work directly with the database

    docker exec -it resto-git-restodb-1 psql -U resto resto

Dump users:

    docker exec resto-git-restodb-1 pg_dump -U resto resto --clean --schema resto --table 'group*|right*|user*' >db-users.sql
