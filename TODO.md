# Post Installation Fixes

## Creating Users

    cat <<EOF | docker exec -it resto-git-restodb-1 psql -U resto resto
    CREATE UNIQUE INDEX idx_name_group2 ON resto.group (name);
    EOF

## Activation Link

A hack to make the activation work using browser.

    cd resto.git
    patch -p1 < ../activate.patch

Note, the proper way would be something different - a wrapper using forms and buttons.
