# scylladb-csdlpt
# install Docker: https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe
- install linux kernel
- (Tải về gói update Linux kernel qua link https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)
- Để WSL 2 làm mặc định khi cài đặt Linux distribution:
```
wsl --set-default-version 2
```
# Start: Working with Scylla Database
Link: [here](https://dev.to/j_a_o_v_c_t_r/working-with-scylla-database-3al9)
- Downloading image
```
docker run --name scylla-db-test -d scylladb/scylla:4.1.0
```
- nodetool: *getting an error*
```
nodetool: Unable to connect to Scylla API server: java.net.ConnectException: Connection refused (Connection refused)
See 'nodetool help' or 'nodetool help <command>'.
```
